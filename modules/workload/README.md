# Workload Layer

The Workload layer provides application-level services including static websites, containerized applications, serverless functions, and batch processing jobs. This layer contains the actual applications and workloads that run on top of the infrastructure foundation.

## 🎯 Overview

The Workload layer provides application-level services including static websites, containerized applications, serverless functions, and batch processing jobs. This layer contains the actual applications and workloads that run on top of the infrastructure foundation.

This layer includes the following GoCloud wrapper modules:

- **[terraform-aws-wrapper-static-site](https://github.com/gocloudLa/terraform-aws-wrapper-static-site)** - CloudFront + S3 static site hosting
- **[terraform-aws-wrapper-ecs-service](https://github.com/gocloudLa/terraform-aws-wrapper-ecs-service)** - Containerized application services
- **[terraform-aws-wrapper-batch-job](https://github.com/gocloudLa/terraform-aws-wrapper-batch-job)** - Scheduled and on-demand batch processing
- **[terraform-aws-wrapper-lambda](https://github.com/gocloudLa/terraform-aws-wrapper-lambda)** - Serverless compute and event processing

## 🚀 Usage

### Prerequisites

- Terraform / OpenTofu >= 1.10
- AWS CLI configured with appropriate permissions
- Base, Foundation, and Project layers deployed (recommended)

### Basic Usage

**main.tf**
```hcl
module "workload" {
  source = "gocloudLa/standard-platform/aws//modules/workload"
  version = "1.0.0"

  metadata = local.metadata

  static_site_parameters = {
    # Static website configuration
  }

  ecs_service_parameters = {
    # ECS service configuration
  }

  batch_job_parameters = {
    # Batch job configuration
  }

  lambda_parameters = {
    # Lambda function configuration
  }
}
```

**metadata.tf**
```hcl
locals {
  metadata = {
    aws_region     = "us-east-1"
    environment    = "Production"
    project        = "Core"
    public_domain  = "gocloud.la"
    private_domain = "gocloud"

    key = {
      company = "gcl"
      region  = "use1"
      env     = "prd"
      project = "core"
      layer   = "workload"
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
| static_site_parameters | Static website configuration | `object` | `{}` | no |
| ecs_service_parameters | ECS service configuration | `object` | `{}` | no |
| batch_job_parameters | Batch job configuration | `object` | `{}` | no |
| lambda_parameters | Lambda function configuration | `object` | `{}` | no |

## 🏷️ Resource Naming Convention

The platform automatically generates resource names using the following patterns:

- **Workload Layer**: `{key.company}-{key.env}-{key.project}` (e.g., `gcl-prd-core`)

### Custom Naming Override

You can override the automatic naming by adding these optional fields to your metadata:

```hcl
locals {
  metadata = {
    # ... other metadata fields ...
    common_name_prefix = "use1-gcl-prd"        # Override: gcl-prd → use1-gcl-prd
    common_name        = "use1-gcl-prd-core"   # Override: gcl-prd-core → use1-gcl-prd-core
  }
}
```

## 🏷️ Resource Tags Convention

The platform automatically generates common tags for all resources:

- **Workload Layer**: `company`, `provisioner`, `environment`, `project`, `created-by`

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
      "project"     = "Core"
      "created-by"  = "GoCloud.la"
      "cost-center" = "IT"             # Custom tag
      "owner"       = "platform-team"  # Custom tag
    }
  }
}
```

## 📋 Example Usage

See the [workload example](../../examples/workload) for a complete implementation example.

## 🤝 Contributing

We welcome contributions! Please see our [contributing guidelines](../../CONTRIBUTING.md) for more details.

## 🆘 Support

- 📧 **Email**: info@gocloud.la
- 🐛 Issues: [GitHub Issues](https://github.com/gocloudLa/terraform-aws-standard-platform/issues)
