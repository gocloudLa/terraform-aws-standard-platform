/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* VPC | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "vpc_parameters" {
  type        = any
  description = "VPC parameters to configure VPC module"
  default     = {}
}

variable "vpc_defaults" {
  type        = any
  description = "VPC default parameters to configure VPC module"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* TGW | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "tgw_parameters" {
  type        = any
  description = "TGW parameters to configure TGW module"
  default     = {}
}

variable "tgw_defaults" {
  type        = any
  description = "TGW default parameters to configure TGW module"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Route53 | Variable Definition                                        */
/*----------------------------------------------------------------------*/
variable "route53_parameters" {
  type        = any
  description = "Route53 parameters to configure Route53 module"
  default     = {}
}

variable "route53_defaults" {
  type        = any
  description = "Route53 default parameters to configure Route53 module"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* CloudMap | Variable Definition                                       */
/*----------------------------------------------------------------------*/
variable "cloudmap_parameters" {
  type        = any
  description = "CloudMap parameters to configure CloudMap module"
  default     = {}
}

variable "cloudmap_defaults" {
  type        = any
  description = "CloudMap default parameters to configure CloudMap module"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Notifications | Variable Definition                                  */
/*----------------------------------------------------------------------*/
variable "notifications_parameters" {
  type        = any
  description = "Notifications parameters to configure notification resources"
  default     = {}
}

variable "notifications_defaults" {
  type        = any
  description = "Notifications default parameters to configure notification resources"
  default     = {}
}