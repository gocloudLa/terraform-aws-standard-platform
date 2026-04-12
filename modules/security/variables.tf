/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* CloudTrail | Variable Definition                                     */
/*----------------------------------------------------------------------*/

variable "cloudtrail_parameters" {
  type        = any
  description = "CloudTrail parameters to configure organization or account trails, S3 delivery, and related audit settings"
  default     = {}
}

variable "cloudtrail_defaults" {
  type        = any
  description = "CloudTrail default parameters applied when individual trail entries omit optional settings"
  default     = {}
}
