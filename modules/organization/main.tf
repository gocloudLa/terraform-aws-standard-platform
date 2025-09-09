module "wrapper_organization" {
  source  = "gocloudLa/wrapper-organization/aws"
  version = "1.0.0"

  metadata = var.metadata

  organization_parameters = var.organization_parameters

}

module "wrapper_identity_center" {
  source  = "gocloudLa/wrapper-identity-center/aws"
  version = "1.0.0"

  metadata = var.metadata

  identity_center_parameters = var.identity_center_parameters

  organization_account_ids = module.wrapper_organization.account_ids
}

module "wrapper_s3_backend" {
  source  = "gocloudLa/wrapper-s3-backend/aws"
  version = "1.0.0"

  metadata = var.metadata

  s3_backend_parameters = var.s3_backend_parameters
  s3_backend_defaults   = var.s3_backend_defaults

}