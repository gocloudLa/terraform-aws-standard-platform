/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* GitLab | Variable Definition                                         */
/*----------------------------------------------------------------------*/
variable "gitlab_runner_parameters" {
  type        = any
  description = "GitLab runner parameters to configure GitLab runner module"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* ACM | Variable Definition                                            */
/*----------------------------------------------------------------------*/
variable "acm_parameters" {
  type        = any
  description = "ACM parameters to configure ACM module"
  default     = {}
}

variable "acm_defaults" {
  type        = any
  description = "ACM default parameters to configure ACM module"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* SES | Variable Definition                                            */
/*----------------------------------------------------------------------*/
variable "ses_parameters" {
  type        = any
  description = "SES parameters to configure SES module"
  default     = {}
}

variable "ses_defaults" {
  type        = any
  description = "SES default parameters to configure SES module"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Route53 | Variable Definition                                        */
/*----------------------------------------------------------------------*/
variable "route53_parameters" {
  type        = any
  description = "Route53 parameters to declare records in hosted zone"
  default     = {}
}

variable "route53_defaults" {
  type        = any
  description = "Route53 default parameters to declare records in hosted zone"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Pritunl | Variable Definition                                        */
/*----------------------------------------------------------------------*/
variable "pritunl_parameters" {
  type        = any
  description = "Pritunl parameters to configure VPN infrastructure"
  default     = {}
}

variable "pritunl_defaults" {
  type        = any
  description = "Pritunl default parameters to configure VPN infrastructure"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* AWS Backup | Variable Definition                                     */
/*----------------------------------------------------------------------*/
variable "aws_backup_parameters" {
  type        = any
  description = "AWS Backup parameters to configure backup resources"
  default     = {}
}

variable "aws_backup_defaults" {
  type        = any
  description = "AWS Backup default parameters to configure backup resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Service Scheduler | Variable Definition                              */
/*----------------------------------------------------------------------*/
variable "service_scheduler_parameters" {
  type        = any
  description = "Service Scheduler parameters to configure scheduling resources"
  default     = {}
}

variable "service_scheduler_defaults" {
  type        = any
  description = "Service Scheduler default parameters to configure scheduling resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* WAF | Variable Definition                                            */
/*----------------------------------------------------------------------*/
variable "waf_parameters" {
  type        = any
  description = "WAF parameters to configure Web Application Firewall"
  default     = {}
}

variable "waf_defaults" {
  type        = any
  description = "WAF default parameters to configure Web Application Firewall"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Health Events | Variable Definition                                  */
/*----------------------------------------------------------------------*/
variable "health_events_parameters" {
  type        = any
  description = "Health Events parameters to configure monitoring resources"
  default     = {}
}

variable "health_events_defaults" {
  type        = any
  description = "Health Events default parameters to configure monitoring resources"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Cost Control | Variable Definition                                   */
/*----------------------------------------------------------------------*/
variable "cost_control_parameters" {
  type        = any
  description = "Cost Control parameters to configure cost optimization resources"
  default     = {}
}

variable "cost_control_defaults" {
  type        = any
  description = "Cost Control default parameters to configure cost optimization resources"
  default     = {}
}
