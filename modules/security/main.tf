module "wrapper_cloudtrail" {
  # source  = "gocloudLa/wrapper-cloudtrail/aws"
  # version = "0.1.0"
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-cloudtrail.git?ref=feature/initial-release"

  providers = {
    aws.log = aws.log
    aws.kms = aws.kms
  }

  metadata = var.metadata

  cloudtrail_parameters = var.cloudtrail_parameters
  cloudtrail_defaults   = var.cloudtrail_defaults
}
