module "wrapper_cloudtrail" {
  source  = "gocloudLa/wrapper-cloudtrail/aws"
  version = "0.1.0"

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
