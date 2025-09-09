data "aws_ssm_parameter" "terraform" {
  name = "/terraform/${local.common_name}-base"
}

locals {
  secrets = jsondecode(data.aws_ssm_parameter.terraform.value)
  # alarms_discord_webhook_url
  # notifications_discord_webhook_url
}