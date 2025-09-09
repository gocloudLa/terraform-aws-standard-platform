# AWS Standard Platform Terraform module

[![Latest Release](https://img.shields.io/github/v/release/gocloudLa/terraform-aws-standard-platform.svg?style=for-the-badge)](https://github.com/gocloudLa/terraform-aws-standard-platform/releases/latest)
[![Last Commit](https://img.shields.io/github/last-commit/gocloudLa/terraform-aws-standard-platform.svg?style=for-the-badge)](https://github.com/gocloudLa/terraform-aws-standard-platform/commits/main)
[![Terraform Registry](https://img.shields.io/badge/Terraform-Registry-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://registry.terraform.io/modules/gocloudLa/standard-platform/aws)

## 🚀 Enterprise-Ready AWS Infrastructure Platform

**The most comprehensive and battle-tested AWS infrastructure platform for modern enterprises.**

Built by GoCloud's team of AWS experts, this platform provides everything you need to deploy production-ready, secure, and scalable AWS infrastructure in minutes, not months.

### ✨ Why Choose Our Standard Platform?

- **🏗️ Layered Architecture**: Five distinct layers (Organization → Base → Foundation → Project → Workload) for maximum flexibility and governance
- **🔧 50+ AWS Services**: Pre-configured integrations with all major AWS services through our battle-tested wrapper modules
- **🛡️ Security by Design**: Enterprise-grade security controls, compliance standards, and best practices built-in
- **📊 Cost Optimized**: Built-in cost control, monitoring, and optimization features
- **🔄 Multi-Environment**: Seamlessly deploy across Development, Staging, and Production environments
- **📈 Production Ready**: Used by dozens of enterprises in production environments
- **⚡ Fast Deployment**: Deploy complex infrastructure in minutes with our proven patterns
- **🎯 Terraform Registry**: Available on Terraform Registry for easy integration

### 🏆 Trusted by Leading Companies

Our platform powers infrastructure for companies ranging from startups to Fortune 500 enterprises, handling everything from simple web applications to complex multi-region, multi-account architectures.

## Usage

Please refer to the AWS published [Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/) for up-to-date guidance on AWS best practices.

### Organization Layer

Creates AWS Organizations management, Identity Center (SSO), and S3 backend for Terraform state. Module instantiation is once per organization.

📖 **[View Organization Module Documentation](modules/organization/README.md)**

```hcl
module "organization" {
  source = "gocloudLa/standard-platform/aws//modules/organization"

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

### Base Layer

Creates foundational networking infrastructure including VPC, Route53 zones, CloudMap service discovery, and SNS notifications.

📖 **[View Base Module Documentation](modules/base/README.md)**

```hcl
module "base" {
  source = "gocloudLa/standard-platform/aws//modules/base"

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

### Foundation Layer

Creates security, compliance, backup, and operational services including ACM certificates, GitLab Runner, AWS Backup, SES, VPN, WAF, and monitoring.

📖 **[View Foundation Module Documentation](modules/foundation/README.md)**

```hcl
module "foundation" {
  source = "gocloudLa/standard-platform/aws//modules/foundation"

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

  # ... other foundation parameters
}
```

### Project Layer

Creates core infrastructure services including load balancers, compute clusters, databases, storage, and messaging services.

📖 **[View Project Module Documentation](modules/project/README.md)**

```hcl
module "project" {
  source = "gocloudLa/standard-platform/aws//modules/project"

  metadata = local.metadata

  alb_parameters = {
    # Application Load Balancer configuration
  }

  ecs_parameters = {
    # ECS cluster configuration
  }

  rds_parameters = {
    # RDS database configuration
  }

  # ... other project parameters
}
```

### Workload Layer

Creates application-level services including static websites, containerized applications, serverless functions, and batch processing jobs.

📖 **[View Workload Module Documentation](modules/workload/README.md)**

```hcl
module "workload" {
  source = "gocloudLa/standard-platform/aws//modules/workload"

  metadata = local.metadata

  static_site_parameters = {
    # Static website configuration
  }

  ecs_service_parameters = {
    # ECS service configuration
  }

  lambda_parameters = {
    # Lambda function configuration
  }

  # ... other workload parameters
}
```

## Authors

Module is maintained by [GoCloud Team](https://github.com/gocloudLa) with help from [these awesome contributors](https://github.com/gocloudLa/terraform-aws-standard-platform/graphs/contributors).

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.10 |
| aws | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 6.0 |
| aws.use1 | >= 6.0 (for CloudFront resources) |

## License

Apache-2.0 Licensed. See [LICENSE](LICENSE).

## 🤝 Contributing

We welcome contributions! Please see our [contributing guidelines](CONTRIBUTING.md) for more details.

## 🆘 Support

- 📧 **Email**: info@gocloud.la
- 🐛 Issues: [GitHub Issues](https://github.com/gocloudLa/terraform-aws-standard-platform/issues)

## 🧑‍💻 About

We are focused on Cloud Engineering, DevOps, and Infrastructure as Code.
We specialize in helping companies design, implement, and operate secure and scalable cloud-native platforms.

- 🌎 [www.gocloud.la](https://www.gocloud.la)
- ☁️ AWS Advanced Partner (Terraform, DevOps, GenAI)
- 📫 Contact: info@gocloud.la

---

**Made with ❤️ by the GoCloud Team**