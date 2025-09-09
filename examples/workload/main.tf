module "workload_core" {

  source = "../../modules/workload"

  providers = {
    aws.use1 = aws.use1
  }

  /*----------------------------------------------------------------------*/
  /* General Variables                                                    */
  /*----------------------------------------------------------------------*/

  metadata = local.metadata

  /*----------------------------------------------------------------------*/
  /* Static Site Parameters                                               */
  /*----------------------------------------------------------------------*/

  static_site_parameters = {
    www = {
      acm_certificate_arn   = data.aws_acm_certificate.this.arn
      custom_error_response = local.custom_error_response
      dns_records = {
        "www" = {
          zone_name    = "${local.zone_public}"
          private_zone = false
        }
        "_null_" = {
          zone_name    = "${local.zone_public}"
          private_zone = false
        }
      }
    }
  }

  /*----------------------------------------------------------------------*/
  /* ECS Service Parameters                                               */
  /*----------------------------------------------------------------------*/

  ecs_service_parameters = {

    filebrowser = {
      enable_autoscaling = false

      enable_execute_command = true

      capacity_provider_strategy = {
        fargate_spot = {
          base              = null
          capacity_provider = "FARGATE_SPOT"
          weight            = 100
        }
      }

      # Policies que usan la tasks desde el codigo desarrollado
      tasks_iam_role_policies   = {}
      tasks_iam_role_statements = []
      # Policies que usa el servicio para poder iniciar tasks (ecr / ssm / etc)
      task_exec_iam_role_policies = {}
      task_exec_iam_statements    = []

      ecs_task_volume_efs = {
        volume1 = {
          efs_name     = "dmc-prd-core-00"
          access_point = "volume1"
        }
      }

      # https://filebrowser.gocloud.la/filebrowser/files/
      # admin / {PASSWORD_IN_LOGS}
      containers = {
        app = {
          image                 = "hurlenko/filebrowser:latest"
          create_ecr_repository = false

          map_environment = {
            "FB_BASEURL" = "/"
          }
          map_secrets = {}
          mount_points_efs = {
            volume1 = {
              container_path = "/data/volume1/files"
              read_only      = false
            }
          }
          ports = {
            "port1" = {
              container_port = 8080
              load_balancer = {
                "alb1" = {
                  target_group_custom_name = "${local.common_name}-filebrowser"

                  alb_name             = "dmc-prd-core-external-00"
                  alb_listener_port    = 443
                  deregistration_delay = 60
                  slow_start           = 30
                  health_check         = {}
                  dns_records = {
                    "filebrowser" = {
                      zone_name    = "${local.zone_public}"
                      private_zone = false
                    }
                  }
                  listener_rules = {
                    "rule1" = {
                      conditions = [
                        {
                          host_headers = ["filebrowser.${local.zone_public}"]
                        }
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    pma = {
      enable_autoscaling     = false
      cpu                    = 512
      memory                 = 1024
      enable_execute_command = true
      # privileged             = true

      capacity_provider_strategy = {
        fargate_spot = {
          base              = null
          capacity_provider = "FARGATE_SPOT"
          weight            = 100
        }
      }

      containers = {
        "app" = {
          image = "public.ecr.aws/docker/library/phpmyadmin"
          map_environment = {
            "PMA_HOSTS" = "dmc-prd-core-00.rds.democorp" # "${jsondecode(data.aws_secretsmanager_secret_version.database_connection.secret_string)["host"]}"
            # "PMA_USER"  = "${jsondecode(data.aws_secretsmanager_secret_version.database_connection.secret_string)["username"]}"
            "PMA_ABSOLUTE_URI" = "https://pma.${local.zone_public}"
            "UPLOAD_LIMIT"     = "300M"
            # root / 4QUr6GFZcEoORwRQsAe7pWlLm3HDGT
          }
          map_secrets = {
            # "PMA_PASSWORD"     = "${jsondecode(data.aws_secretsmanager_secret_version.database_connection.secret_string)["password"]}"
          }
          # entrypoint  = [""]
          # command = [""]
          ports = {
            "port1" = {
              container_port = 80
              load_balancer = {
                "alb1" = {
                  alb_name             = "dmc-prd-core-external-00"
                  alb_listener_port    = 443
                  deregistration_delay = 300
                  slow_start           = 60
                  dns_records = {
                    "pma" = {
                      zone_name    = "${local.zone_public}"
                      private_zone = false
                    }
                  }
                  listener_rules = {
                    "rule1" = {
                      conditions = [
                        {
                          host_headers = ["pma.${local.zone_public}"]
                        }
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

}
