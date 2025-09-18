# Organization Layer

The Organization layer provides enterprise-level AWS account management, identity services, and state management capabilities. This layer is typically deployed once per AWS organization and establishes the foundational governance and identity infrastructure.

## 🎯 Overview

The Organization layer provides enterprise-level AWS account management, identity services, and state management capabilities. This layer is typically deployed once per AWS organization and establishes the foundational governance and identity infrastructure.

This layer includes the following GoCloud wrapper modules:

- **[terraform-aws-wrapper-organization](https://github.com/gocloudLa/terraform-aws-wrapper-organization)** - Manages AWS Organizations, organizational units, and policies
- **[terraform-aws-wrapper-identity-center](https://github.com/gocloudLa/terraform-aws-wrapper-identity-center)** - Centralized identity and access management
- **[terraform-aws-wrapper-s3-backend](https://github.com/gocloudLa/terraform-aws-wrapper-s3-backend)** - Terraform state management and remote state storage

## 🚀 Usage

### Prerequisites

- Terraform / OpenTofu >= 1.10
- AWS CLI configured with appropriate permissions
- AWS Organizations permissions (if creating new organization)

### Basic Usage

**main.tf**
```hcl
module "organization" {
  source = "gocloudLa/standard-platform/aws//modules/organization"
  # version = "{tag_specific_version}"

  metadata = local.metadata

  organization_parameters = {
    # Organization configuration
  }

  identity_center_parameters = {
    # Identity Center configuration
  }

  s3_backend_parameters = {
    # S3 Backend configuration
  }
}
```

**metadata.tf**
```hcl
locals {
  metadata = {
    aws_region     = "us-east-1"
    environment    = "Production"
    public_domain  = "gocloud.la"
    private_domain = "gocloud"

    key = {
      company = "gcl"
      region  = "use1"
      env     = "prd"
      layer   = "organization"
    }
  }
}
```


## 📋 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.10 |
| aws | >= 6.0 |

## 🔧 Providers

| Name | Version |
|------|---------|
| aws | >= 6.0 |

## 📥 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| metadata | Common metadata for all resources | `object` | n/a | yes |
| organization_parameters | Organization management configuration | `object` | `{}` | no |
| identity_center_parameters | Identity Center (SSO) configuration | `object` | `{}` | no |
| s3_backend_parameters | S3 backend for Terraform state | `object` | `{}` | no |

## 🏷️ Resource Naming Convention

The platform automatically generates resource names using the following patterns:

- **Organization Layer**: `{key.company}-{key.env}` (e.g., `gcl-prd`)

### Custom Naming Override

You can override the automatic naming by adding these optional fields to your metadata:

```hcl
locals {
  metadata = {
    # ... other metadata fields ...
    common_name = "use1-gcl-prd"        # Override: gcl-prd → use1-gcl-prd
  }
}
```

## 🏷️ Resource Tags Convention

The platform automatically generates common tags for all resources:

- **Organization Layer**: `company`, `provisioner`, `environment`, `created-by`

### Custom Tags Override

You can override the automatic tags by adding `common_tags` to your metadata:

```hcl
locals {
  metadata = {
    # ... other metadata fields ...
    common_tags = {
      "company"     = "gcl"
      "provisioner" = "terraform"
      "environment" = "Production"
      "created-by"  = "GoCloud.la"
      "cost-center" = "IT"             # Custom tag
    }
  }
}
```

## 📋 Example Usage

See the [organization example](../../examples/organization) for a complete implementation example.

## 🤝 Contributing

We welcome contributions! Please see our [contributing guidelines](../../CONTRIBUTING.md) for more details.

## 🆘 Support

- 📧 **Email**: info@gocloud.la
- 🐛 Issues: [GitHub Issues](https://github.com/gocloudLa/terraform-aws-standard-platform/issues)
