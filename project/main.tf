module "wrapper_alb" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-alb.git?ref=feature/initial-release"

  metadata = var.metadata

  alb_parameters = var.alb_parameters
  alb_defaults   = var.alb_defaults
}

module "wrapper_batch" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-batch.git?ref=feature/initial-release"

  metadata = var.metadata

  batch_parameters = var.batch_parameters
  batch_defaults   = var.batch_defaults
}

module "wrapper_ecs" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-ecs.git?ref=feature/initial-release"

  metadata = var.metadata

  ecs_parameters = var.ecs_parameters
  ecs_defaults   = var.ecs_defaults
}

module "wrapper_elasticache" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-elasticache.git?ref=feature/initial-release"

  metadata = var.metadata

  elasticache_parameters = var.elasticache_parameters
  elasticache_defaults   = var.elasticache_defaults
}

module "wrapper_documentdb" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-documentdb.git?ref=feature/initial-release"

  metadata = var.metadata

  documentdb_parameters = var.documentdb_parameters
  documentdb_defaults   = var.documentdb_defaults
}

module "wrapper_rds" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-rds.git?ref=feature/initial-release"

  metadata = var.metadata

  rds_parameters = var.rds_parameters
  rds_defaults   = var.rds_defaults
}

module "wrapper_rds_aurora" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-rds-aurora.git?ref=feature/initial-release"

  metadata = var.metadata

  rds_aurora_parameters = var.rds_aurora_parameters
  rds_aurora_defaults   = var.rds_aurora_defaults
}

module "wrapper_sqs" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-sqs.git?ref=feature/initial-release"

  metadata = var.metadata

  sqs_parameters = var.sqs_parameters
  sqs_defaults   = var.sqs_defaults
}

module "wrapper_dynamodb" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-dynamodb.git?ref=feature/initial-release"

  metadata = var.metadata

  dynamodb_parameters = var.dynamodb_parameters
  dynamodb_defaults   = var.dynamodb_defaults
}

module "wrapper_bucket" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-bucket.git?ref=feature/initial-release"

  metadata = var.metadata

  bucket_parameters = var.bucket_parameters
  bucket_defaults   = var.bucket_defaults
}

module "wrapper_efs" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-efs.git?ref=feature/initial-release"

  metadata = var.metadata

  efs_parameters = var.efs_parameters
  efs_defaults   = var.efs_defaults
}

module "wrapper_memorydb" {
  source = "git@github.com:gocloudLa/terraform-aws-wrapper-memorydb.git?ref=feature/initial-release"

  metadata = var.metadata

  memorydb_parameters = var.memorydb_parameters
  memorydb_defaults   = var.memorydb_defaults
}
