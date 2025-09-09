# data "aws_ssm_parameter" "terraform" {
#   name = "/terraform/${local.common_name}-workload"
# }

# locals {
#   secrets = jsondecode(data.aws_ssm_parameter.terraform.value)
# }