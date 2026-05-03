#!/usr/bin/env python3
"""
Check Terraform dependencies (modules + providers) against the public registry.
Reports what is outdated. Private modules (e.g. gocloudLa/*) will show as
"private/not found" if not on the public registry.

Run from repo root:
  python3 scripts/check-outdated-deps.py
  python3 scripts/check-outdated-deps.py --json-outdated
  # CI: solo análisis → JSON (el workflow hace el for en bash + git/gh)
  python3 scripts/check-outdated-deps.py --bump-plan-json > bump-plan.json
  MODULE_SOURCE=... MODULE_CURRENT=... MODULE_LATEST=... MODULE_PATHS='a.tf|b.tf' \\
    python3 scripts/check-outdated-deps.py --write-bump
  (same env) python3 scripts/check-outdated-deps.py --pr-meta-json
"""
from __future__ import annotations

import json
import os
import re
import sys
from collections import defaultdict
from pathlib import Path
from typing import Any
from urllib.parse import urlparse

try:
    from urllib.error import HTTPError, URLError
    from urllib.request import Request, urlopen
except ImportError:
    from urllib2 import HTTPError, Request, URLError, urlopen  # type: ignore

REGISTRY = "https://registry.terraform.io"
ROOT = Path(__file__).resolve().parent.parent


def parse_semver(v: str) -> tuple[int, ...]:
    """Parse x.y.z into comparable tuple; strip pre-release suffix."""
    v = re.sub(r"[-+].*", "", v.strip())
    parts = v.split(".")
    out: list[int] = []
    for p in parts[:3]:
        try:
            out.append(int(p))
        except ValueError:
            out.append(0)
    return tuple(out)


def cmp_version(current: str, latest: str) -> int:
    """Return -1 if current < latest, 0 if equal, 1 if current > latest."""
    c, l = parse_semver(current), parse_semver(latest)
    if c < l:
        return -1
    if c > l:
        return 1
    return 0


def get_module_versions(namespace: str, name: str, provider: str) -> list[str] | None:
    """Fetch module versions from public registry. Returns None if 404/private."""
    url = f"{REGISTRY}/v1/modules/{namespace}/{name}/{provider}/versions"
    try:
        with urlopen(Request(url, headers={"Accept": "application/json"}), timeout=15) as r:
            data = json.loads(r.read().decode())
    except (HTTPError, URLError, json.JSONDecodeError, OSError):
        return None
    mods = data.get("modules") or []
    if not mods:
        return None
    versions = mods[0].get("versions") or []
    return [vv.get("version") for vv in versions if isinstance(vv.get("version"), str)]


def get_provider_latest(namespace: str, name: str) -> str | None:
    """Fetch provider latest version from public registry. Returns None if error."""
    url = f"{REGISTRY}/v1/providers/{namespace}/{name}"
    try:
        with urlopen(Request(url, headers={"Accept": "application/json"}), timeout=15) as r:
            data = json.loads(r.read().decode())
    except (HTTPError, URLError, json.JSONDecodeError, OSError):
        return None
    return data.get("version")


def latest_version(versions: list[str]) -> str | None:
    """Return latest semver from list (excluding pre-releases)."""
    stable = [v for v in versions if not re.search(r"-[a-zA-Z]", v)]
    if not stable:
        stable = versions
    if not stable:
        return None
    return max(stable, key=lambda v: parse_semver(v))


def collect_tf_deps() -> tuple[list[tuple[str, str, str]], list[tuple[str, str, str]]]:
    """Scan .tf files for registry modules and required_providers."""
    modules: list[tuple[str, str, str]] = []
    providers: list[tuple[str, str, str]] = []

    for tf in ROOT.rglob("*.tf"):
        if ".terraform" in str(tf):
            continue
        text = tf.read_text(errors="replace")
        rel = tf.relative_to(ROOT)

        for m in re.finditer(
            r'module\s+"[^"]+"\s*\{([^}]+)\}',
            text,
            re.DOTALL,
        ):
            block = m.group(1)
            src = re.search(r'source\s*=\s*["\']([^"\']+)["\']', block)
            ver = re.search(r'version\s*=\s*["\']([^"\']+)["\']', block)
            if not src or not ver:
                continue
            source = src.group(1).strip()
            version = ver.group(1).strip()
            if re.match(r"^[a-zA-Z0-9_-]+/[a-zA-Z0-9_.-]+/[a-zA-Z0-9]+$", source):
                modules.append((source, version, str(rel)))

        for m in re.finditer(
            r'required_providers\s*\{([^}]+(?:\{[^}]*\}[^}]*)*)\}',
            text,
            re.DOTALL,
        ):
            block = m.group(1)
            for prov_block in re.finditer(r"(\w+)\s*=\s*\{([^}]*)\}", block):
                inner = prov_block.group(2)
                src = re.search(r'source\s*=\s*["\']([^"\']+)["\']', inner)
                ver = re.search(r'version\s*=\s*["\']([^"\']+)["\']', inner)
                if not src or not ver:
                    continue
                source = src.group(1).strip()
                version = ver.group(1).strip()
                if "/" in source:
                    providers.append((source, version, str(rel)))

    return modules, providers


def get_module_version_detail(namespace: str, name: str, provider: str, version: str) -> dict | None:
    """GET /v1/modules/ns/name/provider/version — source URL, tag, etc."""
    url = f"{REGISTRY}/v1/modules/{namespace}/{name}/{provider}/{version}"
    try:
        with urlopen(Request(url, headers={"Accept": "application/json"}), timeout=20) as r:
            return json.loads(r.read().decode())
    except (HTTPError, URLError, json.JSONDecodeError, OSError):
        return None


def _github_request(url: str) -> dict | list | None:
    token = os.environ.get("GITHUB_TOKEN") or os.environ.get("GH_TOKEN")
    headers = {"Accept": "application/vnd.github+json", "X-GitHub-Api-Version": "2022-11-28"}
    if token:
        headers["Authorization"] = f"Bearer {token}"
    try:
        with urlopen(Request(url, headers=headers), timeout=25) as r:
            return json.loads(r.read().decode())
    except (HTTPError, URLError, json.JSONDecodeError, OSError):
        return None


def _parse_github_repo(source_url: str) -> tuple[str, str] | None:
    if not source_url:
        return None
    u = source_url.rstrip("/")
    if "github.com" not in u:
        return None
    parsed = urlparse(u if "://" in u else "https://" + u)
    path = parsed.path.strip("/")
    parts = path.split("/")
    if len(parts) >= 2:
        return parts[0], parts[1]
    return None


def _compare_commits_subjects(owner: str, repo: str, old_ver: str, new_ver: str) -> list[str]:
    """Return first-line commit messages between tags (tries v-prefixed tags)."""
    subjects: list[str] = []
    for old in (f"v{old_ver}", old_ver):
        for new in (f"v{new_ver}", new_ver):
            url = f"https://api.github.com/repos/{owner}/{repo}/compare/{old}...{new}"
            data = _github_request(url)
            if not isinstance(data, dict) or "commits" not in data:
                continue
            commits = data.get("commits") or []
            for c in commits:
                msg = (c.get("commit") or {}).get("message") or ""
                first = msg.split("\n")[0].strip()
                if first and not first.lower().startswith("merge branch"):
                    subjects.append(first)
            if subjects:
                return subjects
    return subjects


def upstream_commit_titles(source: str, current: str, latest: str) -> list[str]:
    """
    First line of each Git commit between `current` and `latest` for the module's
    source repo (GitHub URL from Terraform Registry). Empty if unknown/private/no compare.
    """
    parts = source.split("/")
    if len(parts) != 3:
        return []
    detail = get_module_version_detail(parts[0], parts[1], parts[2], latest)
    src_url = (detail or {}).get("source") or ""
    gh = _parse_github_repo(src_url)
    if not gh:
        return []
    owner, repo = gh
    return _compare_commits_subjects(owner, repo, current, latest)


_CONVENTIONAL = re.compile(
    r"^(?P<type>feat|fix|perf|refactor|docs|style|test|build|ci|chore|revert)"
    r"(?P<scope>\([^)]+\))?(?P<bang>!)?:",
    re.IGNORECASE,
)


def _primary_dep_prefix(subjects: list[str]) -> str:
    order = ["feat", "fix", "perf", "refactor", "docs", "chore"]
    found: set[str] = set()
    for s in subjects:
        m = _CONVENTIONAL.match(s.strip())
        if m:
            found.add(m.group("type").lower())
    for t in order:
        if t in found:
            return f"{t}(deps)"
    return "chore(deps)"


def _short_module_label(source: str) -> str:
    parts = source.split("/")
    if len(parts) == 3:
        return f"{parts[1]}/{parts[2]}"
    return source


def build_pr_meta(source: str, current: str, latest: str, paths: list[str]) -> dict[str, str]:
    parts = source.split("/")
    marker = f"<!-- terraform-deps:{source}|{current}|{latest} -->"
    body_lines = [
        marker,
        "",
        f"Bump Terraform registry module **`{source}`** from **`{current}`** → **`{latest}`**.",
        "",
        "### Files",
        "",
    ]
    for p in paths:
        body_lines.append(f"- `{p}`")
    body_lines.extend(["", "### Upstream commits", ""])

    subjects = upstream_commit_titles(source, current, latest)
    if len(parts) == 3 and subjects:
        for s in subjects[:30]:
            body_lines.append(f"- {s}")
    elif len(parts) == 3:
        detail = get_module_version_detail(parts[0], parts[1], parts[2], latest)
        src_url = (detail or {}).get("source") or ""
        gh = _parse_github_repo(src_url)
        if gh:
            owner, repo = gh
            body_lines.append(
                f"_No commits listed via [compare](https://github.com/{owner}/{repo}/compare) "
                f"(tags may differ from registry)._"
            )
        else:
            body_lines.append("_Could not resolve GitHub source from registry._")
    else:
        body_lines.append("_Could not resolve module source._")

    prefix = _primary_dep_prefix(subjects)
    short = _short_module_label(source)
    tail_parts: list[str] = []
    for s in subjects[:5]:
        tail_parts.append(s[:120])
    tail = " · ".join(tail_parts) if tail_parts else f"release {latest}"
    title = f"{prefix}: bump {short} {current} → {latest}"
    if tail:
        extra = f" — {tail}"
        if len(title) + len(extra) <= 250:
            title += extra
        elif len(title) < 250:
            title = (title + extra)[:250]
    if len(title) > 250:
        title = title[:247] + "..."

    return {"title": title, "body": "\n".join(body_lines), "marker": marker}


def apply_module_version_bump(source: str, old: str, new: str, paths: list[str]) -> int:
    """Rewrite version pins in-place. Returns number of replacements."""
    total = 0
    pat = re.compile(
        rf'(source\s*=\s*"{re.escape(source)}"\s*\n\s*version\s*=\s*)"{re.escape(old)}"',
        re.MULTILINE,
    )
    for rel in paths:
        path = ROOT / rel
        text = path.read_text(errors="replace")
        new_text, n = pat.subn(rf'\1"{new}"', text)
        if n:
            path.write_text(new_text)
        total += n
    return total


def list_outdated_modules() -> list[dict[str, object]]:
    """
    Return one entry per (source, current_version) that is behind registry latest.
    Each entry: source, current, latest, paths, upstream_commit_titles (first line of
    each commit between current and latest on the module GitHub repo, when available).
    """
    raw_modules, _ = collect_tf_deps()
    grouped: dict[tuple[str, str], list[str]] = defaultdict(list)
    for source, version, path in raw_modules:
        grouped[(source, version)].append(path)

    out: list[dict[str, object]] = []
    for (source, current), paths in sorted(grouped.items()):
        parts = source.split("/")
        if len(parts) != 3:
            continue
        ns, name, prov = parts
        versions = get_module_versions(ns, name, prov)
        if versions is None:
            continue
        latest = latest_version(versions)
        if not latest or cmp_version(current, latest) >= 0:
            continue
        titles = upstream_commit_titles(source, current, latest)
        out.append(
            {
                "source": source,
                "current": current,
                "latest": latest,
                "paths": sorted(set(paths)),
                "upstream_commit_titles": titles,
            }
        )
    return out


def github_matrix_payload() -> dict[str, list[dict[str, str]]]:
    """Matrix rows for workflow_dispatch (paths_join = | separated; commits_json = JSON array string)."""
    include: list[dict[str, str]] = []
    for row in list_outdated_modules():
        source = str(row["source"])
        slug = source.replace("/", "-")
        paths = row["paths"]
        titles = row.get("upstream_commit_titles") or []
        assert isinstance(paths, list)
        assert isinstance(titles, list)
        include.append(
            {
                "slug": slug,
                "source": source,
                "current": str(row["current"]),
                "latest": str(row["latest"]),
                "paths_join": "|".join(str(p) for p in paths),
                "commits_json": json.dumps([str(t) for t in titles]),
            }
        )
    return {"include": include}


def build_bump_plan() -> dict[str, Any]:
    """
    Full plan for CI/bash: each item has versions, paths, branch name, PR title/body/marker,
    and upstream_commit_titles (info messages between current and latest).
    """
    items: list[dict[str, Any]] = []
    for row in list_outdated_modules():
        source = str(row["source"])
        cur = str(row["current"])
        latest = str(row["latest"])
        paths = [str(p) for p in row["paths"]]
        assert isinstance(row["paths"], list)
        titles = row.get("upstream_commit_titles") or []
        assert isinstance(titles, list)
        meta = build_pr_meta(source, cur, latest, paths)
        slug = source.replace("/", "-")
        branch = f"deps/terraform-{slug}-{latest}"
        items.append(
            {
                "source": source,
                "current": cur,
                "latest": latest,
                "paths": paths,
                "branch": branch,
                "pr_title": meta["title"],
                "pr_body": meta["body"],
                "marker": meta["marker"],
                "upstream_commit_titles": [str(t) for t in titles],
            }
        )
    return {"items": items}


def _human_report() -> None:
    modules, providers = collect_tf_deps()

    seen_mod: dict[str, tuple[str, str]] = {}
    for source, version, path in modules:
        if source not in seen_mod or seen_mod[source][0] != version:
            seen_mod[source] = (version, path)

    seen_prov: dict[str, tuple[str, str]] = {}
    for source, version, path in providers:
        if source not in seen_prov:
            seen_prov[source] = (version, path)

    outdated: list[str] = []
    ok: list[str] = []

    print("=== Terraform modules ===\n")
    for source, (current, path) in sorted(seen_mod.items()):
        parts = source.split("/")
        if len(parts) != 3:
            continue
        ns, name, prov = parts
        versions = get_module_versions(ns, name, prov)
        if versions is None:
            print(f"\033[90m  {source} @ {current}  (in {path}) [private/not in public registry]\033[0m")
            continue
        latest = latest_version(versions)
        if not latest:
            continue
        if cmp_version(current, latest) < 0:
            line = f"  {source}  {current} → {latest}  (in {path})"
            outdated.append(line)
            print(f"\033[33mOUTDATED\033[0m {line}")
        else:
            line = f"  {source} @ {current}  (in {path})"
            ok.append(line)
            print(f"\033[32mOK\033[0m {line}")

    print("\n=== Terraform providers (required_providers) ===\n")
    for source, (constraint, path) in sorted(seen_prov.items()):
        parts = source.split("/")
        if len(parts) != 2:
            continue
        ns, name = parts
        latest = get_provider_latest(ns, name)
        if latest is None:
            print(f"  \033[90m{source}  constraint: {constraint}  (in {path}) [not found]\033[0m")
            continue
        print(
            f"  {source}  constraint: {constraint}  |  latest in registry: "
            f"\033[32m{latest}\033[0m  (in {path})"
        )

    if outdated:
        print("\n\033[1mSummary: %d module(s) have a newer version available.\033[0m" % len(outdated))
        sys.exit(1)
    print("\n\033[1mSummary: No outdated modules (or only private modules).\033[0m")
    sys.exit(0)


def main() -> None:
    if "--bump-plan-json" in sys.argv:
        json.dump(build_bump_plan(), sys.stdout, indent=2)
        sys.stdout.write("\n")
        sys.exit(0)
    if "--json-outdated" in sys.argv:
        data = list_outdated_modules()
        json.dump(data, sys.stdout, indent=2)
        sys.stdout.write("\n")
        sys.exit(0)
    if "--github-matrix" in sys.argv:
        json.dump(github_matrix_payload(), sys.stdout, separators=(",", ":"))
        sys.stdout.write("\n")
        sys.exit(0)
    if "--write-bump" in sys.argv:
        src = os.environ.get("MODULE_SOURCE", "").strip()
        cur = os.environ.get("MODULE_CURRENT", "").strip()
        lat = os.environ.get("MODULE_LATEST", "").strip()
        raw_paths = os.environ.get("MODULE_PATHS", "").strip()
        paths = [p.strip() for p in raw_paths.split("|") if p.strip()]
        if not (src and cur and lat and paths):
            print("Need MODULE_SOURCE, MODULE_CURRENT, MODULE_LATEST, MODULE_PATHS", file=sys.stderr)
            sys.exit(1)
        n = apply_module_version_bump(src, cur, lat, paths)
        print(f"Updated {n} version pin(s).", file=sys.stderr)
        if n == 0:
            sys.exit(1)
        sys.exit(0)
    if "--pr-meta-json" in sys.argv:
        src = os.environ.get("MODULE_SOURCE", "").strip()
        cur = os.environ.get("MODULE_CURRENT", "").strip()
        lat = os.environ.get("MODULE_LATEST", "").strip()
        raw_paths = os.environ.get("MODULE_PATHS", "").strip()
        paths = [p.strip() for p in raw_paths.split("|") if p.strip()]
        if not (src and cur and lat and paths):
            print("Need MODULE_* env vars", file=sys.stderr)
            sys.exit(1)
        meta = build_pr_meta(src, cur, lat, paths)
        json.dump(meta, sys.stdout)
        sys.stdout.write("\n")
        sys.exit(0)
    _human_report()


if __name__ == "__main__":
    main()
