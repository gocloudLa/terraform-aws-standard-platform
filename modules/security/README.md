# Security Layer

The Security layer centralizes organization-wide security, compliance and audit services. It runs from the delegated administrator (security) account, with the log archive account holding the central buckets and keys, and is deployed after the Organization layer.

## 🎯 Overview

The Security layer centralizes organization-wide security, compliance and audit services. It runs from the delegated administrator (security) account, with the log archive account holding the central buckets and keys, and is deployed after the Organization layer.

This layer includes the following GoCloud wrapper modules:

- **[terraform-aws-wrapper-guardrails](https://github.com/gocloudLa/terraform-aws-wrapper-guardrails)** - Preventive guardrails (SCP, RCP and declarative policies) attached to the root and OUs
- **[terraform-aws-wrapper-cloudtrail](https://github.com/gocloudLa/terraform-aws-wrapper-cloudtrail)** - Organization trail with central S3 delivery and CloudWatch Logs
- **[terraform-aws-wrapper-securityhub](https://github.com/gocloudLa/terraform-aws-wrapper-securityhub)** - Security Hub CSPM central configuration, standards, policies and finding aggregation
- **[terraform-aws-wrapper-guardduty](https://github.com/gocloudLa/terraform-aws-wrapper-guardduty)** - GuardDuty organization auto-enable, protection plans and findings export
- **[terraform-aws-wrapper-config](https://github.com/gocloudLa/terraform-aws-wrapper-config)** - AWS Config recorders across the organization, central delivery, aggregator and organization rules

## 🚀 Usage

### Prerequisites

- Terraform / OpenTofu >= 1.11.1
- AWS CLI configured with appropriate permissions
- Organization layer deployed: delegated administrators, trusted access and policy types enabled (`service_delegation_parameters` and `organization_parameters`)

### Basic Usage

**main.tf**
```hcl
module "security" {
  source = "gocloudLa/standard-platform/aws//modules/security"
  # version = "{tag_specific_version}"

  providers = {
    aws.org = aws.org # Organizations management account
    aws.sec = aws.sec # Delegated administrator (security) account
    aws.log = aws.log # Log archive account
    aws.kms = aws.log # Account that owns the KMS keys
  }

  metadata = local.metadata

  guardrails_parameters = {
    # Guardrails configuration
  }

  cloudtrail_parameters = {
    # CloudTrail configuration
  }

  securityhub_parameters = {
    # Security Hub configuration
  }

  guardduty_parameters = {
    # GuardDuty configuration
  }

  config_parameters = {
    # AWS Config configuration
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
| terraform | >= 1.11.1 |
| aws | >= 6.70 |
| time | >= 0.9 |

## 🔧 Providers

| Name | Version |
|------|---------|
| aws.org | >= 6.70 |
| aws.sec | >= 6.70 |
| aws.log | >= 6.70 |
| aws.kms | >= 6.70 |

## 📥 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| metadata | Common metadata for all resources | `object` | n/a | yes |
| guardrails_parameters | Preventive guardrails (SCP, RCP, declarative policies) | `object` | `{}` | no |
| cloudtrail_parameters | Organization trail and log delivery | `object` | `{}` | no |
| securityhub_parameters | Security Hub central configuration and policies | `object` | `{}` | no |
| guardduty_parameters | GuardDuty organization configuration and findings export | `object` | `{}` | no |
| config_parameters | AWS Config recorders, aggregator and organization rules | `object` | `{}` | no |

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
