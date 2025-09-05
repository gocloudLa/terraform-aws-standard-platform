module "wrapper_vpc" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-vpc.git?ref=feature/initial-release"

  metadata = var.metadata

  vpc_parameters = var.vpc_parameters
  vpc_defaults   = var.vpc_defaults
}

module "wrapper_route53" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-route53-zone.git?ref=feature/initial-release"

  metadata = var.metadata

  route53_parameters = var.route53_parameters
  route53_defaults   = var.route53_defaults

  vpc_id = module.wrapper_vpc.vpc.vpc_id
}

module "wrapper_cloudmap" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-cloudmap.git?ref=feature/initial-release"

  metadata = var.metadata

  cloudmap_parameters = var.cloudmap_parameters
  cloudmap_defaults   = var.cloudmap_defaults

  vpc_id = module.wrapper_vpc.vpc.vpc_id
}

module "wrapper_notifications" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-notifications.git?ref=feature/initial-release"

  metadata = var.metadata

  notifications_parameters = var.notifications_parameters
  notifications_defaults   = var.notifications_defaults

}