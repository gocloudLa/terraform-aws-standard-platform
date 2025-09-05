/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* Organization | Variable Definition                                   */
/*----------------------------------------------------------------------*/

variable "organization_parameters" {
  type        = any
  description = "Organization parameters to configure organization resources"
  default     = {}
}

variable "identity_center_parameters" {
  type        = any
  description = "Identity Center parameters to configure users and policies for organization accounts"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* S3 Backend | Variable Definition                                     */
/*----------------------------------------------------------------------*/

variable "s3_backend_parameters" {
  type        = any
  description = "S3 Backend parameters to configure Terraform state storage"
  default     = {}
}

variable "s3_backend_defaults" {
  type        = any
  description = "S3 Backend default parameters to configure Terraform state storage"
  default     = {}
}