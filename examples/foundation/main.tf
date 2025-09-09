module "foundation" {

  source = "../../modules/foundation"

  providers = {
    aws.use1 = aws.use1
  }

  /*----------------------------------------------------------------------*/
  /* General Variables                                                    */
  /*----------------------------------------------------------------------*/

  metadata = local.metadata

  /*----------------------------------------------------------------------*/
  /* Gitlab-runner Variables                                              */
  /*----------------------------------------------------------------------*/
  gitlab_runner_parameters = {
    enable                    = true
    runner_registration_token = "xyz" # local.secrets.gitlab_registration_token
    instance_type             = "t3.small"
    enable_schedule           = false
    schedule_config           = local.asg_schedules
    ami_filter                = { name = ["amzn2-ami-hvm-2.0.20250721.2-x86_64-ebs"] }
  }

  /*----------------------------------------------------------------------*/
  /* ACM Variables                                                        */
  /*----------------------------------------------------------------------*/
  acm_parameters = {
    "${local.zone_public}" = {
      route53_zone_name = "${local.zone_public}"
      subject_alternative_names = [
        "*.${local.zone_public}"
      ]
    }
  }

  /*----------------------------------------------------------------------*/
  /* SES Variables                                                        */
  /*----------------------------------------------------------------------*/
  ses_parameters = {
    "${local.zone_public}" = {
    }
  }

  /*----------------------------------------------------------------------*/
  /* Pritunl Variables                                                    */
  /*----------------------------------------------------------------------*/
  # pritunl_parameters = {
  #   enable       = true
  #   domain       = "${local.zone_public}"
  #   aws_ami_name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20221212"
  # }

  /*----------------------------------------------------------------------*/
  /* Route53 Variables                                                    */
  /*----------------------------------------------------------------------*/
  route53_parameters = {
    "${local.zone_public}" = {
      private_zone = false
      records = [
        {
          name = ""
          type = "MX"
          ttl  = "300"
          records = [
            "1 ASPMX.L.GOOGLE.COM",
            "5 ALT1.ASPMX.L.GOOGLE.COM",
            "5 ALT2.ASPMX.L.GOOGLE.COM",
            "10 ALT3.ASPMX.L.GOOGLE.COM",
            "10 ALT4.ASPMX.L.GOOGLE.COM"
          ]
        },
        {
          name = ""
          type = "TXT"
          ttl  = "300"
          records = [
            "v=spf1 include:_spf.google.com ~all"
          ]
        },
        {
          name = "_dmarc"
          type = "TXT"
          ttl  = "300"
          records = [
            "v=DMARC1; p=none;"
          ]
        }
      ]
    }

  }

  /*----------------------------------------------------------------------*/
  /* AWS Backup Variables                                                 */
  /*----------------------------------------------------------------------*/
  aws_backup_parameters = {
    "rds" = {
      backup_plan = {
        "ptr-14days" = {
          rules = {
            "ptr-rds" = {
              enable_continuous_backup = true
              schedule                 = "cron(0 * * * ? *)"
              lifecycle = {
                delete_after = "14"
              }
            }
          }
          selections = {
            "selection" = {
              resources     = []
              not_resources = []
              selection_tags = [
                {
                  type  = "STRINGEQUALS"
                  key   = "ptr-14d"
                  value = "true"
                }
              ]
            }
          }
        }
      }
    }
  }

  /*----------------------------------------------------------------------*/
  /* Health Events Variables                                              */
  /*----------------------------------------------------------------------*/
  health_events_parameters = {
    enable = true
  }
}
