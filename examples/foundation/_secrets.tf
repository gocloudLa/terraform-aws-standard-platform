# data "aws_ssm_parameter" "terraform" {
#   name = "/terraform/${local.common_name}-foundation"
# }

# locals {
#   secrets = jsondecode(data.aws_ssm_parameter.terraform.value)
#   # gitlab_registration_token
# }