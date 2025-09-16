module "wrapper_acm" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-acm.git"

  metadata = var.metadata

  acm_parameters = var.acm_parameters
  acm_defaults   = var.acm_defaults

  providers = {
    aws.use1 = aws.use1
  }
}

module "wrapper_gitlab_runner" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-gitlab-runner.git"

  metadata = var.metadata

  gitlab_runner_parameters = var.gitlab_runner_parameters

}

module "wrapper_aws_backup" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-aws-backup.git"

  metadata = var.metadata

  aws_backup_parameters = var.aws_backup_parameters
  aws_backup_defaults   = var.aws_backup_defaults

}

module "wrapper_ses" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-ses.git"

  metadata = var.metadata

  ses_parameters = var.ses_parameters
  ses_defaults   = var.ses_defaults

}

module "wrapper_pritunl" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-pritunl.git"

  metadata = var.metadata

  pritunl_parameters = var.pritunl_parameters
  pritunl_defaults   = var.pritunl_defaults

}

module "wrapper_route53" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-route53-record.git"

  metadata = var.metadata

  route53_parameters = var.route53_parameters
  route53_defaults   = var.route53_defaults

}

module "wrapper_service_scheduler" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-service-scheduler.git"

  metadata = var.metadata

  service_scheduler_parameters = var.service_scheduler_parameters
  service_scheduler_defaults   = var.service_scheduler_defaults

}

module "wrapper_waf" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-waf.git"

  metadata = var.metadata

  waf_parameters = var.waf_parameters
  waf_defaults   = var.waf_defaults

  providers = {
    aws.use1 = aws.use1
  }
}

module "wrapper_health_events" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-health-events.git"

  metadata = var.metadata

  health_events_parameters = var.health_events_parameters
  health_events_defaults   = var.health_events_defaults

}

module "wrapper_cost_control" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-cost-control.git"

  metadata = var.metadata

  cost_control_parameters = var.cost_control_parameters
  cost_control_defaults   = var.cost_control_defaults

}