module "wrapper_alb" {
  source  = "gocloudLa/wrapper-alb/aws"
  version = "1.0.0"

  metadata = var.metadata

  alb_parameters = var.alb_parameters
  alb_defaults   = var.alb_defaults
}

module "wrapper_batch" {
  source  = "gocloudLa/wrapper-batch/aws"
  version = "1.0.0"

  metadata = var.metadata

  batch_parameters = var.batch_parameters
  batch_defaults   = var.batch_defaults
}

module "wrapper_ecs" {
  source  = "gocloudLa/wrapper-ecs/aws"
  version = "1.0.0"

  metadata = var.metadata

  ecs_parameters = var.ecs_parameters
  ecs_defaults   = var.ecs_defaults
}

module "wrapper_elasticache" {
  source  = "gocloudLa/wrapper-elasticache/aws"
  version = "1.0.0"

  metadata = var.metadata

  elasticache_parameters = var.elasticache_parameters
  elasticache_defaults   = var.elasticache_defaults
}

module "wrapper_documentdb" {
  source  = "gocloudLa/wrapper-documentdb/aws"
  version = "1.0.0"

  metadata = var.metadata

  documentdb_parameters = var.documentdb_parameters
  documentdb_defaults   = var.documentdb_defaults
}

module "wrapper_rds" {
  source  = "gocloudLa/wrapper-rds/aws"
  version = "1.0.0"

  metadata = var.metadata

  rds_parameters = var.rds_parameters
  rds_defaults   = var.rds_defaults
}

module "wrapper_rds_aurora" {
  source  = "gocloudLa/wrapper-rds-aurora/aws"
  version = "1.0.0"

  metadata = var.metadata

  rds_aurora_parameters = var.rds_aurora_parameters
  rds_aurora_defaults   = var.rds_aurora_defaults
}

module "wrapper_sqs" {
  source  = "gocloudLa/wrapper-sqs/aws"
  version = "1.0.0"

  metadata = var.metadata

  sqs_parameters = var.sqs_parameters
  sqs_defaults   = var.sqs_defaults
}

module "wrapper_dynamodb" {
  source  = "gocloudLa/wrapper-dynamodb/aws"
  version = "1.0.0"

  metadata = var.metadata

  dynamodb_parameters = var.dynamodb_parameters
  dynamodb_defaults   = var.dynamodb_defaults
}

module "wrapper_bucket" {
  source  = "gocloudLa/wrapper-bucket/aws"
  version = "1.0.0"

  metadata = var.metadata

  bucket_parameters = var.bucket_parameters
  bucket_defaults   = var.bucket_defaults
}

module "wrapper_efs" {
  source  = "gocloudLa/wrapper-efs/aws"
  version = "1.0.0"

  metadata = var.metadata

  efs_parameters = var.efs_parameters
  efs_defaults   = var.efs_defaults
}

module "wrapper_memorydb" {
  source  = "gocloudLa/wrapper-memorydb/aws"
  version = "1.0.0"

  metadata = var.metadata

  memorydb_parameters = var.memorydb_parameters
  memorydb_defaults   = var.memorydb_defaults
}
