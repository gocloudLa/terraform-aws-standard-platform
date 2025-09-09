# Base Layer

The Base layer provides foundational networking, DNS, service discovery, and notification infrastructure. This layer establishes the core networking foundation that all other layers depend on.

## 🎯 Overview

The Base layer provides foundational networking, DNS, service discovery, and notification infrastructure. This layer establishes the core networking foundation that all other layers depend on.

This layer includes the following GoCloud wrapper modules:

- **[terraform-aws-wrapper-vpc](https://github.com/gocloudLa/terraform-aws-wrapper-vpc)** - Virtual Private Cloud with subnets, routing, and security
- **[terraform-aws-wrapper-route53-zone](https://github.com/gocloudLa/terraform-aws-wrapper-route53-zone)** - DNS zone management for public and private domains
- **[terraform-aws-wrapper-cloudmap](https://github.com/gocloudLa/terraform-aws-wrapper-cloudmap)** - Service discovery and registration within VPC
- **[terraform-aws-wrapper-notifications](https://github.com/gocloudLa/terraform-aws-wrapper-notifications)** - Centralized notification infrastructure

## 🚀 Usage

### Prerequisites

- Terraform / OpenTofu >= 1.10
- AWS CLI configured with appropriate permissions
- Organization layer deployed (recommended)

### Basic Usage

**main.tf**
```hcl
module "base" {
  source = "gocloudLa/standard-platform/aws//modules/base"
  version = "1.0.0"

  metadata = local.metadata

  vpc_parameters = {
    # VPC configuration
  }

  route53_parameters = {
    # Route53 zones configuration
  }

  cloudmap_parameters = {
    # CloudMap service discovery configuration
  }

  notifications_parameters = {
    # SNS notifications configuration
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
      layer   = "base"
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
| vpc_parameters | VPC networking configuration | `object` | `{}` | no |
| route53_parameters | Route53 zones configuration | `object` | `{}` | no |
| cloudmap_parameters | CloudMap service discovery | `object` | `{}` | no |
| notifications_parameters | SNS notifications configuration | `object` | `{}` | no |

## 🏷️ Resource Naming Convention

The platform automatically generates resource names using the following patterns:

- **Base Layer**: `{key.company}-{key.env}` (e.g., `gcl-prd`)

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

- **Base Layer**: `company`, `provisioner`, `environment`, `created-by`

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

See the [base example](../../examples/base) for a complete implementation example.

## 🤝 Contributing

We welcome contributions! Please see our [contributing guidelines](../../CONTRIBUTING.md) for more details.

## 🆘 Support

- 📧 **Email**: info@gocloud.la
- 🐛 Issues: [GitHub Issues](https://github.com/gocloudLa/terraform-aws-standard-platform/issues)
