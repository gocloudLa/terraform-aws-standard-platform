module "project_core" {

  source = "../../modules/project"

  /*----------------------------------------------------------------------*/
  /* General Variables                                                    */
  /*----------------------------------------------------------------------*/

  metadata = local.metadata
  # project  = "core"

  /*----------------------------------------------------------------------*/
  /* ALB Variables                                                        */
  /*----------------------------------------------------------------------*/
  alb_parameters = {
    "external-00" = {
      subnets  = [data.aws_subnets.public.ids[0], data.aws_subnets.public.ids[1]]
      internal = false
      listeners = {
        "80" = {
          port        = 80
          protocol    = "HTTP"
          action_type = "redirect"
          redirect = {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
            host        = "#{host}"
            path        = "/#{path}"
            query       = "#{query}"
          }
        }
        "443" = {
          port            = 443
          protocol        = "HTTPS"
          certificate_arn = data.aws_acm_certificate.this.arn
          action_type     = "fixed-response"
          fixed_response = {
            content_type = "text/plain"
            message_body = "Fixed message"
            status_code  = "200"
          }
        }
      }
      ingress_with_cidr_blocks = [
        {
          rule        = "http-80-tcp"
          cidr_blocks = "0.0.0.0/0"
          description = "Enable all access"
        },
        {
          rule        = "https-443-tcp"
          cidr_blocks = "0.0.0.0/0"
          description = "Enable all access"
        }
      ]
      dns_records = {
        "" = {
          zone_name    = "${local.zone_public}"
          private_zone = false
        }
      }
    }
  }

  /*----------------------------------------------------------------------*/
  /* ECS Variables                                                        */
  /*----------------------------------------------------------------------*/
  ecs_parameters = {
    "00" = {
      cluster_settings = [{
        name  = "containerInsights"
        value = "disabled"
      }]
      default_capacity_provider_strategy = {
        FARGATE = {
          weight = 0
        }
        FARGATE_SPOT = {
          weight = 100
        }
      }
      autoscaling_capacity_providers = {}
    }
  }

  /*----------------------------------------------------------------------*/
  /* RDS Variables                                                        */
  /*----------------------------------------------------------------------*/
  rds_parameters = {
    "00" = {
      engine         = "mariadb"
      engine_version = "10.6"
      subnet_ids     = data.aws_subnets.database.ids
      dns_records = {
        "" = {
          zone_name    = local.zone_private
          private_zone = true
        }
      }
      parameters = [
        {
          name  = "max_connections"
          value = "150"
        }
      ]
      maintenance_window      = "Sun:04:00-Sun:06:00"
      backup_window           = "03:00-03:30"
      backup_retention_period = "7"
      apply_immediately       = true

      # DB MANAGEMENT
      enable_db_management                    = true
      enable_db_management_logs_notifications = true
      db_management_parameters = {
        databases = [
          {
            name    = "database1"
            charset = "utf8mb4"
            collate = "utf8mb4_general_ci"
          }
        ],
        users = [
          {
            username = "user1"
            host     = "%"
            password = "wxz" # "${local.secrets.rds_redmine_password}"
            grants = [
              {
                database   = "database1"
                table      = "*"
                privileges = "ALL"
              }
            ]
          }
        ],
        excluded_users = ["rdsadmin", "root", "mariadb.sys", "healthcheck", "rds_superuser_role", "mysql.infoschema", "mysql.session", "mysql.sys"]
      }
    }
  }

  /*----------------------------------------------------------------------*/
  /* ELASTICACHE Variables                                                */
  /*----------------------------------------------------------------------*/
  elasticache_parameters = {
    # "00" = {
    #   subnets = data.aws_subnets.database.ids
    #   dns_records = {
    #     "" = {
    #       zone_name    = local.zone_private
    #       private_zone = true
    #     }
    #   }
    # }
  }

  /*----------------------------------------------------------------------*/
  /* BUCKET Variables                                                     */
  /*----------------------------------------------------------------------*/
  bucket_parameters = {
    # "uploads" = {
    #   create_bucket                 = true
    #   enable_s3_public_access_block = false
    #   block_public_acls             = true
    #   block_public_policy           = true
    #   ignore_public_acls            = true
    #   restrict_public_buckets       = true
    #   object_ownership              = "BucketOwnerEnforced"
    # }
  }

  /*----------------------------------------------------------------------*/
  /* EFS Variables                                                        */
  /*----------------------------------------------------------------------*/
  efs_parameters = {
    "00" = {
      access_points = {
        "root" = {
          root_directory = {
            path = "/"
            creation_info = {
              owner_gid   = 1001
              owner_uid   = 1001
              permissions = "755"
            }
          }
        }
        "volume1" = {
          root_directory = {
            path = "/volume1"
            creation_info = {
              owner_gid   = 1001
              owner_uid   = 1001
              permissions = "755"
            }
          }
        }
      }
    }
  }
}