# Project Layer

The Project layer provides core infrastructure services including load balancers, compute clusters, databases, storage, and messaging services. This layer contains the foundational infrastructure components that applications depend on.

## 🎯 Overview

The Project layer provides core infrastructure services including load balancers, compute clusters, databases, storage, and messaging services. This layer contains the foundational infrastructure components that applications depend on.

This layer includes the following GoCloud wrapper modules:

- **[terraform-aws-wrapper-alb](https://github.com/gocloudLa/terraform-aws-wrapper-alb)** - HTTP/HTTPS load balancing and routing
- **[terraform-aws-wrapper-batch](https://github.com/gocloudLa/terraform-aws-wrapper-batch)** - Scalable batch computing infrastructure
- **[terraform-aws-wrapper-ecs](https://github.com/gocloudLa/terraform-aws-wrapper-ecs)** - Container orchestration and management
- **[terraform-aws-wrapper-elasticache](https://github.com/gocloudLa/terraform-aws-wrapper-elasticache)** - In-memory caching and data stores
- **[terraform-aws-wrapper-documentdb](https://github.com/gocloudLa/terraform-aws-wrapper-documentdb)** - MongoDB-compatible document database
- **[terraform-aws-wrapper-rds](https://github.com/gocloudLa/terraform-aws-wrapper-rds)** - Relational database services
- **[terraform-aws-wrapper-rds-aurora](https://github.com/gocloudLa/terraform-aws-wrapper-rds-aurora)** - High-performance relational database
- **[terraform-aws-wrapper-sqs](https://github.com/gocloudLa/terraform-aws-wrapper-sqs)** - Message queuing and processing
- **[terraform-aws-wrapper-dynamodb](https://github.com/gocloudLa/terraform-aws-wrapper-dynamodb)** - NoSQL database service
- **[terraform-aws-wrapper-bucket](https://github.com/gocloudLa/terraform-aws-wrapper-bucket)** - Object storage and data lakes
- **[terraform-aws-wrapper-efs](https://github.com/gocloudLa/terraform-aws-wrapper-efs)** - Shared file storage
- **[terraform-aws-wrapper-memorydb](https://github.com/gocloudLa/terraform-aws-wrapper-memorydb)** - Redis-compatible in-memory database

## 🚀 Usage

### Prerequisites

- Terraform / OpenTofu >= 1.10
- AWS CLI configured with appropriate permissions
- Base and Foundation layers deployed (recommended)

### Basic Usage

**main.tf**
```hcl
module "project" {
  source = "gocloudLa/standard-platform/aws//modules/project"
  version = "1.0.0"

  metadata = local.metadata

  alb_parameters = {
    # Application Load Balancer configuration
  }

  batch_parameters = {
    # Batch processing configuration
  }

  ecs_parameters = {
    # ECS cluster configuration
  }

  elasticache_parameters = {
    # ElastiCache configuration
  }

  documentdb_parameters = {
    # DocumentDB configuration
  }

  rds_parameters = {
    # RDS database configuration
  }

  rds_aurora_parameters = {
    # RDS Aurora configuration
  }

  sqs_parameters = {
    # SQS queue configuration
  }

  dynamodb_parameters = {
    # DynamoDB configuration
  }

  bucket_parameters = {
    # S3 bucket configuration
  }

  efs_parameters = {
    # EFS file system configuration
  }

  memorydb_parameters = {
    # MemoryDB configuration
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
      layer   = "project"
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

## 🏷️ Resource Naming Convention

The platform automatically generates resource names using the following patterns:

- **Project Layer**: `{key.company}-{key.env}-{key.project}` (e.g., `gcl-prd-core`)

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

- **Project Layer**: `company`, `provisioner`, `environment`, `project`, `created-by`

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

See the [project example](../../examples/project) for a complete implementation example.

## 🤝 Contributing

We welcome contributions! Please see our [contributing guidelines](../../CONTRIBUTING.md) for more details.

## 🆘 Support

- 📧 **Email**: info@gocloud.la
- 🐛 Issues: [GitHub Issues](https://github.com/gocloudLa/terraform-aws-standard-platform/issues)
