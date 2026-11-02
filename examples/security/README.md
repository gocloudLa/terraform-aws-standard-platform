# Security Example

This example demonstrates a comprehensive setup of organization-wide security services using Terraform: preventive guardrails, organization CloudTrail, Security Hub, GuardDuty and AWS Config. This is a reference example for understanding how to configure the security layer of the AWS Standard Platform.

## 🔧 What's Included

### Analysis of Terraform Configuration

#### Main Purpose
The main purpose is to provide a complete and detailed configuration for deploying the organization security services from the delegated administrator (security) account, with central log delivery to the log archive account.

#### Key Features Demonstrated
- **Guardrails**: SCP, RCP and declarative policies attached to the root and OUs
- **CloudTrail**: Organization trail with central S3 delivery and CloudWatch Logs
- **Security Hub**: Central configuration with standards, configuration policies and cross-Region aggregation
- **GuardDuty**: Organization auto-enable, protection plans and findings export to S3
- **AWS Config**: Recorders in every account and Region, central delivery and organization aggregator

## 🚀 Quick Start

```bash
terraform init
terraform plan
terraform apply
```

## 🔒 Security Notes

⚠️ **Production Considerations**: 
- This example may include configurations that are not suitable for production environments
- Review and customize security settings, access controls, and resource configurations
- Ensure compliance with your organization's security policies
- Consider implementing proper monitoring, logging, and backup strategies

## 📖 Documentation

For detailed module documentation and additional examples, see the main [README.md](../../README.md) file.
