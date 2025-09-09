locals {

  metadata = {
    aws_region    = "us-east-1"
    environment   = "Organization"
    public_domain = "democorp.cloud"

    key = {
      company = "dmc"
      region  = "use1"
      env     = "org"
      layer   = "organization"
    }
  }

  common_name = join("-", [
    local.metadata.key.company,
    local.metadata.key.env
  ])
}
