module "wrapper_base" {
  source = "../../base"

  metadata = {
    aws_region     = "us-east-1"
    environment    = "Production"
    public_domain  = "democorp.cloud"
    private_domain = "democorp"

    key = {
      company = "dmc"
      region  = "use1"
      env     = "prd"
      layer   = "foundation"
    }
  }

  vpc_parameters           = {}
  route53_parameters       = {}
  cloudmap_parameters      = {}
  notifications_parameters = {}
}

module "wrapper_foundation" {
  source = "../../foundation"

  providers = {
    aws.use1 = aws.use1
  }

  metadata = {
    aws_region     = "us-east-1"
    environment    = "Production"
    public_domain  = "democorp.cloud"
    private_domain = "democorp"

    key = {
      company = "dmc"
      region  = "use1"
      env     = "prd"
      layer   = "foundation"
    }
  }

  acm_parameters               = {}
  gitlab_runner_parameters     = {}
  aws_backup_parameters        = {}
  ses_parameters               = {}
  pritunl_parameters           = {}
  route53_parameters           = {}
  service_scheduler_parameters = {}
  waf_parameters               = {}
  health_events_parameters     = {}
  cost_control_parameters      = {}
}

module "wrapper_project" {
  source = "../../project"

  metadata = {
    aws_region     = "us-east-1"
    environment    = "Production"
    project        = "Common"
    public_domain  = "democorp.cloud"
    private_domain = "democorp"

    key = {
      company = "dmc"
      region  = "use1"
      env     = "prd"
      project = "common"
      layer   = "foundation"
    }
  }

  alb_parameters         = {}
  batch_parameters       = {}
  ecs_parameters         = {}
  elasticache_parameters = {}
  documentdb_parameters  = {}
  rds_parameters         = {}
  rds_aurora_parameters  = {}
  sqs_parameters         = {}
  dynamodb_parameters    = {}
  bucket_parameters      = {}
  efs_parameters         = {}
  memorydb_parameters    = {}
}

module "wrapper_workload" {
  source = "../../workload"

  providers = {
    aws.use1 = aws.use1
  }

  metadata = {
    aws_region     = "us-east-1"
    environment    = "Production"
    project        = "Common"
    public_domain  = "democorp.cloud"
    private_domain = "democorp"

    key = {
      company = "dmc"
      region  = "use1"
      env     = "prd"
      project = "common"
      layer   = "foundation"
    }
  }

  static_site_parameters = {}
  ecs_service_parameters = {}
  batch_job_parameters   = {}
  lambda_parameters      = {}
}

