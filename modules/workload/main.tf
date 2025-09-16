module "wrapper_static_site" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-static-site.git"

  metadata = var.metadata

  static_site_parameters = var.static_site_parameters
  static_site_defaults   = var.static_site_defaults

  providers = {
    aws.use1 = aws.use1
  }
}

module "wrapper_ecs_service" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-ecs-service.git"

  metadata = var.metadata

  ecs_service_parameters = var.ecs_service_parameters
  ecs_service_defaults   = var.ecs_service_defaults

}

module "wrapper_batch_job" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-batch-job.git"

  metadata = var.metadata

  batch_job_parameters = var.batch_job_parameters
  batch_job_defaults   = var.batch_job_defaults

}

module "wrapper_lambda" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-lambda.git"

  metadata = var.metadata

  lambda_parameters = var.lambda_parameters
  lambda_defaults   = var.lambda_defaults

}