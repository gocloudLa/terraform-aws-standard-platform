module "wrapper_acm" {
  source  = "gocloudLa/wrapper-acm/aws"
  version = "1.0.0"

  metadata = var.metadata

  acm_parameters = var.acm_parameters
  acm_defaults   = var.acm_defaults

  providers = {
    aws.use1 = aws.use1
  }
}

module "wrapper_gitlab_runner" {
  source  = "gocloudLa/wrapper-gitlab-runner/aws"
  version = "1.0.0"

  metadata = var.metadata

  gitlab_runner_parameters = var.gitlab_runner_parameters

}

module "wrapper_aws_backup" {
  source  = "gocloudLa/wrapper-aws-backup/aws"
  version = "1.0.0"

  metadata = var.metadata

  aws_backup_parameters = var.aws_backup_parameters
  aws_backup_defaults   = var.aws_backup_defaults

}

module "wrapper_ses" {
  source  = "gocloudLa/wrapper-ses/aws"
  version = "1.0.0"

  metadata = var.metadata

  ses_parameters = var.ses_parameters
  ses_defaults   = var.ses_defaults

}

module "wrapper_pritunl" {
  source  = "gocloudLa/wrapper-pritunl/aws"
  version = "1.0.0"

  metadata = var.metadata

  pritunl_parameters = var.pritunl_parameters
  pritunl_defaults   = var.pritunl_defaults

}

module "wrapper_route53" {
  source  = "gocloudLa/wrapper-route53-record/aws"
  version = "1.0.0"

  metadata = var.metadata

  route53_parameters = var.route53_parameters
  route53_defaults   = var.route53_defaults

}

module "wrapper_service_scheduler" {
  source  = "gocloudLa/wrapper-service-scheduler/aws"
  version = "1.0.0"

  metadata = var.metadata

  service_scheduler_parameters = var.service_scheduler_parameters
  service_scheduler_defaults   = var.service_scheduler_defaults

}

module "wrapper_waf" {
  source  = "gocloudLa/wrapper-waf/aws"
  version = "1.0.0"

  metadata = var.metadata

  waf_parameters = var.waf_parameters
  waf_defaults   = var.waf_defaults

  providers = {
    aws.use1 = aws.use1
  }
}

module "wrapper_health_events" {
  source  = "gocloudLa/wrapper-health-events/aws"
  version = "1.0.0"

  metadata = var.metadata

  health_events_parameters = var.health_events_parameters
  health_events_defaults   = var.health_events_defaults

}

module "wrapper_cost_control" {
  source  = "gocloudLa/wrapper-cost-control/aws"
  version = "1.0.0"

  metadata = var.metadata

  cost_control_parameters = var.cost_control_parameters
  cost_control_defaults   = var.cost_control_defaults

}