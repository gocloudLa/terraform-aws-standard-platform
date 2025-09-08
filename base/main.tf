module "wrapper_vpc" {
  source  = "gocloudLa/wrapper-vpc/aws"
  version = "1.0.0"

  metadata = var.metadata

  vpc_parameters = var.vpc_parameters
  vpc_defaults   = var.vpc_defaults
}

module "wrapper_route53" {
  source  = "gocloudLa/wrapper-route53-zone/aws"
  version = "1.0.0"

  metadata = var.metadata

  route53_parameters = var.route53_parameters
  route53_defaults   = var.route53_defaults

  vpc_id = module.wrapper_vpc.vpc.vpc_id
}

module "wrapper_cloudmap" {
  source  = "gocloudLa/wrapper-cloudmap/aws"
  version = "1.0.0"

  metadata = var.metadata

  cloudmap_parameters = var.cloudmap_parameters
  cloudmap_defaults   = var.cloudmap_defaults

  vpc_id = module.wrapper_vpc.vpc.vpc_id
}

module "wrapper_notifications" {
  source  = "gocloudLa/wrapper-notifications/aws"
  version = "1.0.1"

  metadata = var.metadata

  notifications_parameters = var.notifications_parameters
  notifications_defaults   = var.notifications_defaults

}
