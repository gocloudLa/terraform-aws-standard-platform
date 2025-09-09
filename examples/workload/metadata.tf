locals {

  metadata = {
    aws_region  = "us-east-1"
    environment = "Production"
    project     = "core"

    public_domain  = "democorp.cloud"
    private_domain = "democorp"

    key = {
      company = "dmc"
      region  = "use1"
      env     = "prd"
      project = "core"
      layer   = "workload"
    }
  }

  common_name_base = join("-", [
    local.metadata.key.company,
    local.metadata.key.env
  ])

  common_name = join("-", [
    local.common_name_base,
    local.metadata.key.project
  ])

}
