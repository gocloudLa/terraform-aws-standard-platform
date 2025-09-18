# Foundation Layer

The Foundation layer provides security, compliance, backup, and operational services that form the security and operational foundation for your AWS infrastructure. This layer implements enterprise-grade security controls and operational capabilities.

## 🎯 Overview

The Foundation layer provides security, compliance, backup, and operational services that form the security and operational foundation for your AWS infrastructure. This layer implements enterprise-grade security controls and operational capabilities.

This layer includes the following GoCloud wrapper modules:

- **[terraform-aws-wrapper-acm](https://github.com/gocloudLa/terraform-aws-wrapper-acm)** - SSL/TLS certificate management and validation
- **[terraform-aws-wrapper-gitlab-runner](https://github.com/gocloudLa/terraform-aws-wrapper-gitlab-runner)** - CI/CD infrastructure for automated deployments
- **[terraform-aws-wrapper-aws-backup](https://github.com/gocloudLa/terraform-aws-wrapper-aws-backup)** - Centralized backup and disaster recovery
- **[terraform-aws-wrapper-ses](https://github.com/gocloudLa/terraform-aws-wrapper-ses)** - Email delivery and management
- **[terraform-aws-wrapper-pritunl](https://github.com/gocloudLa/terraform-aws-wrapper-pritunl)** - Secure remote access infrastructure
- **[terraform-aws-wrapper-route53-record](https://github.com/gocloudLa/terraform-aws-wrapper-route53-record)** - DNS record management
- **[terraform-aws-wrapper-service-scheduler](https://github.com/gocloudLa/terraform-aws-wrapper-service-scheduler)** - Automated service scheduling and management
- **[terraform-aws-wrapper-waf](https://github.com/gocloudLa/terraform-aws-wrapper-waf)** - Web Application Firewall protection
- **[terraform-aws-wrapper-health-events](https://github.com/gocloudLa/terraform-aws-wrapper-health-events)** - Infrastructure health monitoring
- **[terraform-aws-wrapper-cost-control](https://github.com/gocloudLa/terraform-aws-wrapper-cost-control)** - Cost optimization and monitoring

## 🚀 Usage

### Prerequisites

- Terraform / OpenTofu >= 1.10
- AWS CLI configured with appropriate permissions
- Base layer deployed (recommended)

### Basic Usage

**main.tf**
```hcl
module "foundation" {
  source = "gocloudLa/standard-platform/aws//modules/foundation"
  # version = "{tag_specific_version}"

  metadata = local.metadata

  acm_parameters = {
    # ACM certificate configuration
  }

  gitlab_runner_parameters = {
    # GitLab Runner configuration
  }

  aws_backup_parameters = {
    # AWS Backup configuration
  }

  ses_parameters = {
    # SES email service configuration
  }

  pritunl_parameters = {
    # VPN infrastructure configuration
  }

  route53_parameters = {
    # Route53 records configuration
  }

  service_scheduler_parameters = {
    # Service scheduling configuration
  }

  waf_parameters = {
    # Web Application Firewall configuration
  }

  health_events_parameters = {
    # Health events monitoring configuration
  }

  cost_control_parameters = {
    # Cost control and optimization
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
      layer   = "foundation"
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
| aws.use1 | >= 6.0 (for CloudFront resources) |

## 📥 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| metadata | Common metadata for all resources | `object` | n/a | yes |
| acm_parameters | ACM certificate configuration | `object` | `{}` | no |
| gitlab_runner_parameters | GitLab runner configuration | `object` | `{}` | no |
| aws_backup_parameters | AWS Backup configuration | `object` | `{}` | no |
| ses_parameters | SES email service configuration | `object` | `{}` | no |
| pritunl_parameters | VPN infrastructure configuration | `object` | `{}` | no |
| route53_parameters | Route53 records configuration | `object` | `{}` | no |
| service_scheduler_parameters | Service scheduling configuration | `object` | `{}` | no |
| waf_parameters | Web Application Firewall configuration | `object` | `{}` | no |
| health_events_parameters | Health events monitoring configuration | `object` | `{}` | no |
| cost_control_parameters | Cost control and optimization | `object` | `{}` | no |

## 🏷️ Resource Naming Convention

The platform automatically generates resource names using the following patterns:

- **Foundation Layer**: `{key.company}-{key.env}` (e.g., `gcl-prd`)

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

- **Foundation Layer**: `company`, `provisioner`, `environment`, `created-by`

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

See the [foundation example](../../examples/foundation) for a complete implementation example.

## 🤝 Contributing

We welcome contributions! Please see our [contributing guidelines](../../CONTRIBUTING.md) for more details.

## 🆘 Support

- 📧 **Email**: info@gocloud.la
- 🐛 Issues: [GitHub Issues](https://github.com/gocloudLa/terraform-aws-standard-platform/issues)
