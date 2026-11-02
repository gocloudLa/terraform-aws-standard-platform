/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* GuardRails | Variable Definition                                     */
/*----------------------------------------------------------------------*/

variable "guardrails_parameters" {
  type        = any
  description = "Guardrails parameters to configure AWS Organization preventive guardrails (SCP, RCP, Declarative Policies)"
  default     = {}
}

variable "guardrails_defaults" {
  type        = any
  description = "Guardrails default parameters applied"
  default     = {}
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

/*----------------------------------------------------------------------*/
/* Security Hub | Variable Definition                                   */
/*----------------------------------------------------------------------*/

variable "securityhub_parameters" {
  type        = any
  description = "Security Hub parameters to configure organization central configuration, standards, policies and finding aggregation"
  default     = {}
}

variable "securityhub_defaults" {
  type        = any
  description = "Security Hub default parameters applied when individual configuration policies omit optional settings"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* GuardDuty | Variable Definition                                      */
/*----------------------------------------------------------------------*/

variable "guardduty_parameters" {
  type        = any
  description = "GuardDuty parameters to configure organization auto-enable, protection features and findings export"
  default     = {}
}

variable "guardduty_defaults" {
  type        = any
  description = "GuardDuty default parameters applied when individual entries omit optional settings"
  default     = {}
}

/*----------------------------------------------------------------------*/
/* Config | Variable Definition                                         */
/*----------------------------------------------------------------------*/

variable "config_parameters" {
  type        = any
  description = "AWS Config parameters to configure recorders across the organization, central delivery, aggregator and organization rules"
  default     = {}
}

variable "config_defaults" {
  type        = any
  description = "AWS Config default parameters applied when individual entries omit optional settings"
  default     = {}
}
