output "wrapper_vpc" {
  description = ""
  value       = module.wrapper_vpc
}

output "wrapper_tgw" {
  description = ""
  value       = module.wrapper_tgw
}

output "wrapper_vpn" {
  description = ""
  value       = module.wrapper_vpn
}

output "route53_zones" {
  description = "Name servers of Route53 zone"
  value       = module.wrapper_route53.route53_zones
}
