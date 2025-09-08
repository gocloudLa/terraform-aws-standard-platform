# Terraform AWS Standard Platform

[![Latest Release](https://img.shields.io/github/v/release/gocloudLa/terraform-aws-standard-platform.svg?style=for-the-badge)](https://github.com/gocloudLa/terraform-aws-standard-platform/releases/latest)
[![Last Commit](https://img.shields.io/github/last-commit/gocloudLa/terraform-aws-standard-platform.svg?style=for-the-badge)](https://github.com/gocloudLa/terraform-aws-standard-platform/commits/main)
[![Terraform Registry](https://img.shields.io/badge/Terraform-Registry-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://registry.terraform.io/modules/gocloudLa/standard-platform/aws)

GoCloud's Standard Platform - Enterprise-ready AWS infrastructure deployment solution

## 🎯 Overview

The Terraform AWS Standard Platform is a comprehensive, enterprise-ready infrastructure-as-code solution that provides a standardized approach to deploying AWS resources across different environments. This platform is designed to accelerate cloud adoption while maintaining security, compliance, and operational excellence.

### Key Features

- **🏗️ Layered Architecture**: Organized into logical layers (Organization, Foundation, Base, Project, Workload)
- **🔧 Modular Design**: Built on top of GoCloud's wrapper modules for maximum flexibility
- **🛡️ Security First**: Implements security best practices and compliance standards
- **📊 Cost Optimization**: Built-in cost control and monitoring capabilities
- **🔄 Scalable**: Supports multi-account, multi-region deployments
- **📈 Monitoring**: Comprehensive observability and alerting out of the box

## 🏛️ Architecture

The platform follows a hierarchical architecture pattern with five distinct layers:

```
┌─────────────────────────────────────────────────────────────┐
│                    Organization Layer                       │
│  • AWS Organizations Management                             │
│  • Identity Center (SSO)                                    │
│  • S3 Backend for State Management                          │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                      Base Layer                             │
│  • VPC Networking                                           │
│  • Route53 Zones                                            │
│  • CloudMap Service Discovery                               │
│  • SNS Notifications                                        │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                    Foundation Layer                         │
│  • ACM Certificates                                         │
│  • GitLab Runner                                            │
│  • AWS Backup                                               │
│  • SES Email Service                                        │
│  • VPN (Pritunl)                                            │
│  • Route53 Records                                          │
│  • Service Scheduler                                        │
│  • WAF (Web Application Firewall)                           │
│  • Health Events Monitoring                                 │
│  • Cost Control                                             │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                    Project Layer                            │
│  • Application Load Balancer (ALB)                          │
│  • Batch Processing                                         │
│  • ECS Clusters                                             │
│  • ElastiCache                                              │
│  • DocumentDB                                               │
│  • RDS & RDS Aurora                                         │
│  • SQS Queues                                               │
│  • DynamoDB                                                 │
│  • S3 Buckets                                               │
│  • EFS File Systems                                         │
│  • MemoryDB                                                 │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                    Workload Layer                           │
│  • Static Websites (CloudFront + S3)                        │
│  • ECS Services                                             │
│  • Batch Jobs                                               │
│  • Lambda Functions                                         │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- Terraform / OpenTofu >= 1.0
- AWS CLI configured
- Appropriate AWS permissions

### Metadata Configuration

The platform uses a standardized metadata structure to generate consistent resource naming and tagging across all layers. Create a `metadata.tf` file in your project root with the following format:

#### For Organization, Base, and Foundation Layers

```hcl
# metadata.tf
locals {
  metadata = {
    aws_region  = "us-east-1"           # AWS region for resources
    environment = "Production"          # Environment name (Production, Staging, Development)

    public_domain  = "gocloud.la"       # Public domain for external resources
    private_domain = "gocloud"          # Private domain for internal resources

    key = {
      company = "gcl"                   # Company abbreviation (2-3 chars)
      region  = "use1"                  # Region abbreviation (us-east-1 = use1)
      env     = "prd"                   # Environment abbreviation (Production = prd) (2-3 chars)
      layer   = "base"                  # Layer name (organization/base/foundation)
    }
  }
}
```

#### For Project and Workload Layers

```hcl
# metadata.tf
locals {
  metadata = {
    aws_region  = "us-east-1"           # AWS region for resources
    environment = "Production"          # Environment name
    project     = "Core"                # Project name (required for project/workload layers)

    public_domain  = "gocloud.la"       # Public domain for external resources
    private_domain = "gocloud"          # Private domain for internal resources

    key = {
      company = "gcl"                   # Company abbreviation (2-3 chars)
      region  = "use1"                  # Region abbreviation (us-east-1 = use1)
      env     = "prd"                   # Environment abbreviation (Production = prd) (2-3 chars)
      project = "core"                  # Project abbreviation (required for project/workload)
      layer   = "project"               # Layer name (project/workload)
    }
  }
}
```

#### Resource Naming Convention

The platform automatically generates resource names using the following patterns:

- **Organization/Base/Foundation**: `{key.company}-{key.env}` (e.g., `gcl-prd`)
- **Project/Workload**: `{key.company}-{key.env}-{key.project}` (e.g., `gcl-prd-core`)

#### Custom Naming Override

You can override the automatic naming by adding these optional fields to your metadata:

**Organization/Base/Foundation layers:**
```hcl
locals {
  metadata = {
    # ... other metadata fields ...
    common_name = "use1-gcl-prd"        # Override: gcl-prd → use1-gcl-prd
  }
}
```

**Project/Workload layers:**
```hcl
locals {
  metadata = {
    # ... other metadata fields ...
    common_name_prefix = "use1-gcl-prd"        # Override: gcl-prd → use1-gcl-prd
    common_name        = "use1-gcl-prd-core"   # Override: gcl-prd-core → use1-gcl-prd-core
  }
}
```

#### Resource Tags Convention

The platform automatically generates common tags for all resources:

- **Organization/Base/Foundation**: `company`, `provisioner`, `environment`, `created-by`
- **Project/Workload**: `company`, `provisioner`, `environment`, `project`, `created-by`

#### Custom Tags Override

You can override the automatic tags by adding `common_tags` to your metadata:

**Organization/Base/Foundation layers:**
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

**Project/Workload layers:**
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

### Basic Usage

```hcl
# Organization Layer
module "wrapper_organization" {
  source = "gocloudLa/standard-platform/aws//organization"
  version = "1.0.0"

  metadata = local.metadata

  organization_parameters = {}
  identity_center_parameters = {}
  s3_backend_parameters = {}
}

# Base Layer
module "wrapper_base" {
  source = "gocloudLa/standard-platform/aws//base"
  version = "1.0.0"

  metadata = local.metadata

  vpc_parameters = {}
  route53_parameters = {}
  cloudmap_parameters = {}
  notifications_parameters = {}
}

# Foundation Layer
module "wrapper_foundation" {
  source = "gocloudLa/standard-platform/aws//foundation"
  version = "1.0.0"

  metadata = local.metadata

  acm_parameters = {}
  gitlab_runner_parameters = {}
  aws_backup_parameters = {}
  ses_parameters = {}
  pritunl_parameters = {}
  route53_parameters = {}
  service_scheduler_parameters = {}
  waf_parameters = {}
  health_events_parameters = {}
  cost_control_parameters = {}
}

# Project Layer
module "wrapper_project" {
  source = "gocloudLa/standard-platform/aws//project"
  version = "1.0.0"

  metadata = local.metadata

  alb_parameters = {}
  batch_parameters = {}
  ecs_parameters = {}
  elasticache_parameters = {}
  documentdb_parameters = {}
  rds_parameters = {}
  rds_aurora_parameters = {}
  sqs_parameters = {}
  dynamodb_parameters = {}
  bucket_parameters = {}
  efs_parameters = {}
  memorydb_parameters = {}
}

# Workload Layer
module "wrapper_workload" {
  source = "gocloudLa/standard-platform/aws//workload"
  version = "1.0.0"

  metadata = local.metadata

  static_site_parameters = {}
  ecs_service_parameters = {}
  batch_job_parameters = {}
  lambda_parameters = {}
}
```

## 📚 Module Documentation

For detailed parameter configurations and examples, refer to the complete examples in each module repository:

### Organization Layer
- [Identity Center Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-identity-center)
- [Organization Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-organization)
- [S3 Backend Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-s3-backend)

### Base Layer
- [Notifications Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-notifications)
- [VPC Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-vpc)
- [Route53 Zone Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-route53-zone)
- [CloudMap Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-cloudmap)

### Foundation Layer
- [Pritunl Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-pritunl)
- [GitLab Runner Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-gitlab-runner)
- [AWS Backup Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-aws-backup)
- [SES Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-ses)
- [ACM Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-acm)
- [Route53 Record Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-route53-record)
- [Service Scheduler Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-service-scheduler)
- [WAF Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-waf)
- [Health Events Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-health-events)
- [Cost Control Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-cost-control)

### Project Layer
- [Bucket Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-bucket)
- [ALB Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-alb)
- [ECS Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-ecs)
- [SQS Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-sqs)
- [ElastiCache Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-elasticache)
- [MemoryDB Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-memorydb)
- [RDS Aurora Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-rds-aurora)
- [DocumentDB Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-documentdb)
- [RDS Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-rds)
- [EFS Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-efs)
- [DynamoDB Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-dynamodb)
- [Batch Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-batch)

### Workload Layer
- [Lambda Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-lambda)
- [ECS Service Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-ecs-service)
- [Static Site Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-static-site)
- [Batch Job Documentation](https://github.com/gocloudLa/terraform-aws-wrapper-batch-job)

## 📋 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |

## 🔧 Providers

| Name | Version |
|------|---------|
| aws | >= 5.0 |
| aws.use1 | >= 5.0 (for CloudFront resources) |

## 📥 Inputs

### Common Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| metadata | Common metadata for all resources | `object` | n/a | yes |

### Organization Layer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| organization_parameters | Organization management configuration | `object` | `{}` | no |
| identity_center_parameters | Identity Center (SSO) configuration | `object` | `{}` | no |
| s3_backend_parameters | S3 backend for Terraform state | `object` | `{}` | no |

### Base Layer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_parameters | VPC networking configuration | `object` | `{}` | no |
| route53_parameters | Route53 zones configuration | `object` | `{}` | no |
| cloudmap_parameters | CloudMap service discovery | `object` | `{}` | no |
| notifications_parameters | SNS notifications configuration | `object` | `{}` | no |

### Foundation Layer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
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

### Project Layer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb_parameters | Application Load Balancer configuration | `object` | `{}` | no |
| batch_parameters | Batch processing configuration | `object` | `{}` | no |
| ecs_parameters | ECS cluster configuration | `object` | `{}` | no |
| elasticache_parameters | ElastiCache configuration | `object` | `{}` | no |
| documentdb_parameters | DocumentDB configuration | `object` | `{}` | no |
| rds_parameters | RDS database configuration | `object` | `{}` | no |
| rds_aurora_parameters | RDS Aurora configuration | `object` | `{}` | no |
| sqs_parameters | SQS queue configuration | `object` | `{}` | no |
| dynamodb_parameters | DynamoDB configuration | `object` | `{}` | no |
| bucket_parameters | S3 bucket configuration | `object` | `{}` | no |
| efs_parameters | EFS file system configuration | `object` | `{}` | no |
| memorydb_parameters | MemoryDB configuration | `object` | `{}` | no |

### Workload Layer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| static_site_parameters | Static website configuration | `object` | `{}` | no |
| ecs_service_parameters | ECS service configuration | `object` | `{}` | no |
| batch_job_parameters | Batch job configuration | `object` | `{}` | no |
| lambda_parameters | Lambda function configuration | `object` | `{}` | no |

## 🤝 Contributing
We welcome contributions! Please see our contributing guidelines for more details.

## 🆘 Support
- 📧 **Email**: info@gocloud.la
- 🐛 Issues: [GitHub Issues](https://github.com/gocloudLa/terraform-aws-standard-platform/issues)


## 🧑‍💻 About
We are focused on Cloud Engineering, DevOps, and Infrastructure as Code.
We specialize in helping companies design, implement, and operate secure and scalable cloud-native platforms.
- 🌎 [www.gocloud.la](https://www.gocloud.la)
- ☁️ AWS Advanced Partner (Terraform, DevOps, GenAI)
- 📫 Contact: info@gocloud.la

## 📄 License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details. 

---

**Made with ❤️ by the GoCloud Team**