# Security Layer

The Security layer groups cross-cutting security and audit capabilities that are deployed deliberately (often in a dedicated log or security account), separate from application networking and shared operational services in Foundation.

## 🎯 Overview
Today this layer wraps a single GoCloud module for AWS CloudTrail. Additional security wrappers (for example GuardDuty, Security Hub, or detective controls) can be added here over time without mixing them into Foundation or Project.

This layer includes the following GoCloud wrapper module:

- **[terraform-aws-wrapper-cloudtrail](https://github.com/gocloudLa/terraform-aws-wrapper-cloudtrail)** - AWS CloudTrail trails, log delivery, and related audit configuration

## 🚀 Usage

### Prerequisites

- Terraform / OpenTofu >= 1.10
- AWS CLI configured with appropriate permissions
- Organization layer deployed (recommended)

### Basic Usage

**main.tf**
```hcl
module "security" {
  source = "gocloudLa/standard-platform/aws//modules/security"
  # version = "{tag_specific_version}"

  providers = {
    aws     = aws
    aws.log = aws
    aws.kms = aws
  }

  metadata = local.metadata

  cloudtrail_parameters = {
    # CloudTrail configuration
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
      layer   = "security"
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
| aws.log | >= 6.0 |
| aws.kms | >= 6.0 |

## 📥 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| metadata | Common metadata for all resources | `object` | n/a | yes |
| cloudtrail_parameters | CloudTrail configuration | `object` | `{}` | no |

## 🏷️ Resource Naming Convention

The platform automatically generates resource names using the following patterns:

- **Security Layer**: `{key.company}-{key.env}` (e.g., `gcl-prd`)

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

- **Security Layer**: `company`, `provisioner`, `environment`, `created-by`

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

See the [security example](../../examples/security) for a complete implementation example.

## 🤝 Contributing

We welcome contributions! Please see our [contributing guidelines](../../CONTRIBUTING.md) for more details.

## 🆘 Support

- 📧 **Email**: info@gocloud.la
- 🐛 Issues: [GitHub Issues](https://github.com/gocloudLa/terraform-aws-standard-platform/issues)
