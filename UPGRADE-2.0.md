# Upgrade — Base networking (breaking)

## What changed

| Area | Before | After |
|------|--------|--------|
| VPC wrapper | `1.2.1` | `2.0.0` |
| Route53 Zone | `1.0.0` + root `vpc_id` | `2.1.0` + `vpc_parameter` |
| CloudMap | `1.0.0` + root `vpc_id` | `2.0.0` + `vpc_parameter` |
| Peering / TGW / VPN | — | New optional wrappers (`0.1.0`) |

## Callers must update

### 1. VPC — migrate `vpc_parameters` to wrapper VPC v2 shape

See [terraform-aws-wrapper-vpc/UPGRADE-2.0.md](https://github.com/gocloudLa/terraform-aws-wrapper-vpc/blob/main/UPGRADE-2.0.md).

### 2. Route53 — flatten zones + VPC per private zone

```hcl
# Before
route53_parameters = {
  zones = {
    "lab.democorp" = { private = true }
  }
}

# After
route53_parameters = {
  "lab.democorp" = {
    private = true
    vpc     = "networking" # or vpc_id = "vpc-xxxxxxxxxxxxxx"
  }
}
```

See [terraform-aws-wrapper-route53-zone/UPGRADE-2.0.md](https://github.com/gocloudLa/terraform-aws-wrapper-route53-zone/blob/main/UPGRADE-2.0.md).

### 3. CloudMap — VPC via `vpc` / `vpc_id` per namespace

Root `vpc_id` is gone; each namespace entry supplies `vpc` or `vpc_id`.

### 4. Optional new inputs (default `{}`)

`peering_parameters`, `tgw_parameters`, `vpn_parameters` (+ matching `*_defaults`).
