data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${local.common_name_base}"]
  }
}

data "aws_acm_certificate" "this" {
  provider = aws.use1

  domain      = local.zone_public
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

# DATABASE
# data "aws_secretsmanager_secret" "database_connection" {
#   name = "rds-${local.common_name}-00"
# }
# data "aws_secretsmanager_secret_version" "database_connection" {
#   secret_id = data.aws_secretsmanager_secret.database_connection.id
# }
# "${jsondecode(data.aws_secretsmanager_secret_version.database_connection.secret_string)["username"]}"
# "${jsondecode(data.aws_secretsmanager_secret_version.database_connection.secret_string)["password"]}"
# "${jsondecode(data.aws_secretsmanager_secret_version.database_connection.secret_string)["host"]}"
# "${jsondecode(data.aws_secretsmanager_secret_version.database_connection.secret_string)["port"]}"

# SES
# data "aws_secretsmanager_secret" "ses_credentials" {
#   name = "ses-${local.zone_public}"
# }
# data "aws_secretsmanager_secret_version" "ses_credentials" {
#   secret_id = data.aws_secretsmanager_secret.ses_credentials.id
# }
# "${jsondecode(data.aws_secretsmanager_secret_version.ses_credentials.secret_string)["SMTP_ADDRESS"]}"
# "${jsondecode(data.aws_secretsmanager_secret_version.ses_credentials.secret_string)["SMTP_USERNAME"]}"
# "${jsondecode(data.aws_secretsmanager_secret_version.ses_credentials.secret_string)["SMTP_PASSWORD"]}"
# "${jsondecode(data.aws_secretsmanager_secret_version.ses_credentials.secret_string)["SMTP_PORT"]}"
# "no-reply@${jsondecode(data.aws_secretsmanager_secret_version.ses_credentials.secret_string)["SMTP_DOMAIN"]}"