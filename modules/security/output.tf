output "cloudtrail" {
  description = "CloudTrail wrapper module outputs"
  value       = module.wrapper_cloudtrail
}

output "guardrails" {
  description = "Guardrails wrapper module outputs"
  value       = module.wrapper_guardrails
}

output "securityhub" {
  description = "Security Hub wrapper module outputs"
  value       = module.wrapper_securityhub
}

output "guardduty" {
  description = "GuardDuty wrapper module outputs"
  value       = module.wrapper_guardduty
}

output "config" {
  description = "AWS Config wrapper module outputs"
  value       = module.wrapper_config
}
