module "wrapper_static_site" {
  source  = "gocloudLa/wrapper-static-site/aws"
  version = "1.0.1"

  metadata = var.metadata

  static_site_parameters = var.static_site_parameters
  static_site_defaults   = var.static_site_defaults

  providers = {
    aws.use1 = aws.use1
  }
}

module "wrapper_ecs_service" {
  source  = "gocloudLa/wrapper-ecs-service/aws"
  version = "1.1.0"

  metadata = var.metadata

  ecs_service_parameters = var.ecs_service_parameters
  ecs_service_defaults   = var.ecs_service_defaults

}

module "wrapper_batch_job" {
  source  = "gocloudLa/wrapper-batch-job/aws"
  version = "1.0.2"

  metadata = var.metadata

  batch_job_parameters = var.batch_job_parameters
  batch_job_defaults   = var.batch_job_defaults

}

module "wrapper_lambda" {
  source  = "gocloudLa/wrapper-lambda/aws"
  version = "1.0.1"

  metadata = var.metadata

  lambda_parameters = var.lambda_parameters
  lambda_defaults   = var.lambda_defaults

}

module "wrapper_ec2_instance" {
  source  = "gocloudLa/wrapper-ec2-instance/aws"
  version = "0.1.0"

  metadata = var.metadata

  ec2_instance_parameters = var.ec2_instance_parameters
  ec2_instance_defaults   = var.ec2_instance_defaults
}