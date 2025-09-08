output "account_ids" {
  value = module.wrapper_organization.account_ids
}

output "user_ids" {
  value = module.wrapper_identity_center.user_ids
}

output "group_ids" {
  value = module.wrapper_identity_center.group_ids
}

output "permission_set_ids" {
  value = module.wrapper_identity_center.permission_set_ids
}