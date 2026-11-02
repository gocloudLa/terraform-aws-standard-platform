module "wrapper_guardrails" {
  # source = "../../../terraform-aws-wrapper-guardrails"
  source  = "gocloudLa/wrapper-guardrails/aws"
  version = "0.1.0"

  providers = {
    aws.org = aws.org
  }

  metadata = var.metadata

  guardrails_parameters = var.guardrails_parameters
  guardrails_defaults   = var.guardrails_defaults
}

module "wrapper_cloudtrail" {
  # source = "../../../terraform-aws-wrapper-cloudtrail"
  source  = "gocloudLa/wrapper-cloudtrail/aws"
  version = "0.1.1"

  providers = {
    aws.org = aws.org
    aws.sec = aws.sec
    aws.log = aws.log
    aws.kms = aws.kms
  }

  metadata = var.metadata

  cloudtrail_parameters = var.cloudtrail_parameters
  cloudtrail_defaults   = var.cloudtrail_defaults
}

module "wrapper_securityhub" {
  # source = "../../../terraform-aws-wrapper-securityhub"
  source  = "gocloudLa/wrapper-securityhub/aws"
  version = "0.1.0"

  providers = {
    aws.org = aws.org
    aws.sec = aws.sec
  }

  metadata = var.metadata

  securityhub_parameters = var.securityhub_parameters
  securityhub_defaults   = var.securityhub_defaults
}

module "wrapper_guardduty" {
  # source = "../../../terraform-aws-wrapper-guardduty"
  source  = "gocloudLa/wrapper-guardduty/aws"
  version = "0.1.0"

  providers = {
    aws.org = aws.org
    aws.sec = aws.sec
    aws.log = aws.log
    aws.kms = aws.kms
  }

  metadata = var.metadata

  guardduty_parameters = var.guardduty_parameters
  guardduty_defaults   = var.guardduty_defaults
}

module "wrapper_config" {
  # source = "../../../terraform-aws-wrapper-config"
  source  = "gocloudLa/wrapper-config/aws"
  version = "0.1.0"

  providers = {
    aws.org = aws.org
    aws.sec = aws.sec
    aws.log = aws.log
    aws.kms = aws.kms
  }

  metadata = var.metadata

  config_parameters = var.config_parameters
  config_defaults   = var.config_defaults
}
