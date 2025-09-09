provider "aws" {
  region = local.metadata.aws_region
}

provider "aws" {
  alias  = "sha"
  region = local.metadata.aws_region

  # assume_role {
  #   role_arn     = "arn:aws:iam::444444444444:role/OrganizationAccountAccessRole"
  #   session_name = "TerraformSession"
  # }
}