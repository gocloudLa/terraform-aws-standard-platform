/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* ALB | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "alb_parameters" {
  type        = any
  description = "ALB parameters to configure Application Load Balancer resources"
  default     = {}
}

variable "alb_defaults" {
  type        = any
  description = "ALB default parameters to configure Application Load Balancer resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* BATCH | Variable Definition                                          */
/*----------------------------------------------------------------------*/

variable "batch_parameters" {
  type        = any
  description = "Batch parameters to configure batch processing resources"
  default     = {}
}

variable "batch_defaults" {
  type        = any
  description = "Batch default parameters to configure batch processing resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* ECS | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "ecs_parameters" {
  type        = any
  description = "ECS parameters to configure container orchestration resources"
  default     = {}
}

variable "ecs_defaults" {
  type        = any
  description = "ECS default parameters to configure container orchestration resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* ElastiCache (Redis) | Variable Definition                            */
/*----------------------------------------------------------------------*/

variable "elasticache_parameters" {
  type        = any
  description = "ElastiCache parameters to configure in-memory data stores"
  default     = {}
}

variable "elasticache_defaults" {
  type        = any
  description = "ElastiCache default parameters to configure in-memory data stores"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* DocumentDB | Variable Definition                                     */
/*----------------------------------------------------------------------*/

variable "documentdb_parameters" {
  type        = any
  description = "DocumentDB parameters to configure MongoDB-compatible databases"
  default     = {}
}

variable "documentdb_defaults" {
  type        = any
  description = "DocumentDB default parameters to configure MongoDB-compatible databases"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* SQS | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "sqs_parameters" {
  type        = any
  description = "SQS parameters to configure message queuing resources"
  default     = {}
}

variable "sqs_defaults" {
  type        = any
  description = "SQS default parameters to configure message queuing resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* DynamoDB | Variable Definition                                       */
/*----------------------------------------------------------------------*/

variable "dynamodb_parameters" {
  type        = any
  description = "DynamoDB parameters to configure NoSQL database tables"
  default     = {}
}

variable "dynamodb_defaults" {
  type        = any
  description = "DynamoDB default parameters to configure NoSQL database tables"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* RDS | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "rds_parameters" {
  type        = any
  description = "RDS parameters to configure relational database instances"
  default     = {}
}

variable "rds_defaults" {
  type        = any
  description = "RDS default parameters to configure relational database instances"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* RDS Aurora | Variable Definition                                     */
/*----------------------------------------------------------------------*/

variable "rds_aurora_parameters" {
  type        = any
  description = "RDS Aurora parameters to configure Aurora database clusters"
  default     = {}
}

variable "rds_aurora_defaults" {
  type        = any
  description = "RDS Aurora default parameters to configure Aurora database clusters"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* BUCKET | Variable Definition                                         */
/*----------------------------------------------------------------------*/

variable "bucket_parameters" {
  type        = any
  description = "S3 bucket parameters to configure object storage resources"
  default     = {}
}

variable "bucket_defaults" {
  type        = any
  description = "S3 bucket default parameters to configure object storage resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* EFS | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "efs_parameters" {
  type        = any
  description = "EFS parameters to configure file storage resources"
  default     = {}
}

variable "efs_defaults" {
  type        = any
  description = "EFS default parameters to configure file storage resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* MemoryDB | Variable Definition                                       */
/*----------------------------------------------------------------------*/

variable "memorydb_parameters" {
  type        = any
  description = "MemoryDB parameters to configure Redis-compatible databases"
  default     = {}
}

variable "memorydb_defaults" {
  type        = any
  description = "MemoryDB default parameters to configure Redis-compatible databases"
  default     = {}
}