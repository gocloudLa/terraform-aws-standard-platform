module "wrapper_organization" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-organization.git"

  metadata = var.metadata

  organization_parameters = var.organization_parameters

}

module "wrapper_identity_center" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-identity-center.git"

  metadata = var.metadata

  identity_center_parameters = var.identity_center_parameters

  organization_account_ids = module.wrapper_organization.account_ids
}

module "wrapper_s3_backend" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-s3-backend.git"

  metadata = var.metadata

  s3_backend_parameters = var.s3_backend_parameters
  s3_backend_defaults   = var.s3_backend_defaults

}