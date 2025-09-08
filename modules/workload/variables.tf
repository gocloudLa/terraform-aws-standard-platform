/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* Static Site | Variable Definition                                    */
/*----------------------------------------------------------------------*/

variable "static_site_parameters" {
  type        = any
  description = "Static site parameters to configure static website hosting"
  default     = {}
}

variable "static_site_defaults" {
  type        = any
  description = "Static site default parameters to configure static website hosting"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* ECS Service | Variable Definition                                    */
/*----------------------------------------------------------------------*/

variable "ecs_service_parameters" {
  type        = any
  description = "ECS service parameters to configure containerized application services"
  default     = {}
}

variable "ecs_service_defaults" {
  type        = any
  description = "ECS service default parameters to configure containerized application services"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Batch Job | Variable Definition                                      */
/*----------------------------------------------------------------------*/

variable "batch_job_parameters" {
  type        = any
  description = "Batch job parameters to configure scheduled batch processing"
  default     = {}
}

variable "batch_job_defaults" {
  type        = any
  description = "Batch job default parameters to configure scheduled batch processing"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Lambda | Variable Definition                                         */
/*----------------------------------------------------------------------*/

variable "lambda_parameters" {
  type        = any
  description = "Lambda parameters to configure serverless functions"
  default     = {}
}

variable "lambda_defaults" {
  type        = any
  description = "Lambda default parameters to configure serverless functions"
  default     = {}
}