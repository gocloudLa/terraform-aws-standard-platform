#!/usr/bin/env python3
"""
Check Terraform dependencies (modules + providers) against the public registry.
Reports what is outdated. Private modules (e.g. gocloudLa/*) will show as "private/not found".
Run from repo root: python3 scripts/check-outdated-deps.py
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

try:
    from urllib.request import Request, urlopen
    from urllib.error import HTTPError, URLError
except ImportError:
    from urllib2 import Request, urlopen, HTTPError, URLError  # type: ignore

REGISTRY = "https://registry.terraform.io"
ROOT = Path(__file__).resolve().parent.parent


def parse_semver(v: str) -> tuple[int, ...]:
    """Parse x.y.z into comparable tuple; strip pre-release suffix."""
    v = re.sub(r"[-+].*", "", v.strip())
    parts = v.split(".")
    out = []
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
    """Scan .tf files for registry modules and required_providers. Returns (modules, providers)."""
    modules: list[tuple[str, str, str]] = []  # (source_key, version, file)
    providers: list[tuple[str, str, str]] = []  # (source_key, version, file)

    for tf in ROOT.rglob("*.tf"):
        if ".terraform" in str(tf):
            continue
        text = tf.read_text(errors="replace")
        rel = tf.relative_to(ROOT)

        # module "x" { source = "ns/name/provider" version = "1.0.0" }
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

        # required_providers { aws = { source = "hashicorp/aws" version = ">= 6.0" } }
        for m in re.finditer(
            r'required_providers\s*\{([^}]+(?:\{[^}]*\}[^}]*)*)\}',
            text,
            re.DOTALL,
        ):
            block = m.group(1)
            for prov_block in re.finditer(r'(\w+)\s*=\s*\{([^}]*)\}', block):
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


def main() -> None:
    modules, providers = collect_tf_deps()

    # Dedupe by (source, version) and attach one file for display
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
    private: list[str] = []

    print("=== Terraform modules ===\n")
    for source, (current, path) in sorted(seen_mod.items()):
        parts = source.split("/")
        if len(parts) != 3:
            continue
        ns, name, prov = parts
        versions = get_module_versions(ns, name, prov)
        if versions is None:
            private.append(f"  {source} @ {current}  (in {path}) [private/not in public registry]")
            continue
        latest = latest_version(versions)
        if not latest:
            continue
        if cmp_version(current, latest) < 0:
            outdated.append(f"  {source}  {current} → {latest}  (in {path})")
        else:
            ok.append(f"  {source} @ {current}  (in {path})")

    for line in outdated:
        print(f"\033[33mOUTDATED\033[0m {line}")
    for line in ok:
        print(f"\033[32mOK\033[0m {line}")
    for line in private:
        print(f"\033[90m{line}\033[0m")

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
        # Constraint like ">= 6.0" – we only show latest available
        print(f"  {source}  constraint: {constraint}  |  latest in registry: \033[32m{latest}\033[0m  (in {path})")

    if outdated:
        print("\n\033[1mSummary: %d module(s) have a newer version available.\033[0m" % len(outdated))
        sys.exit(1)
    print("\n\033[1mSummary: No outdated modules (or only private modules).\033[0m")
    sys.exit(0)


if __name__ == "__main__":
    main()
