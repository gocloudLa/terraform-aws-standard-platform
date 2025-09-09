module "base" {

  source = "../../modules/base"

  /*----------------------------------------------------------------------*/
  /* General Variables                                                    */
  /*----------------------------------------------------------------------*/

  metadata = local.metadata

  /*----------------------------------------------------------------------*/
  /* Notifications Variables                                              */
  /*----------------------------------------------------------------------*/
  notifications_parameters = {
    enable                            = true
    notifications_discord_webhook_url = local.secrets.notifications_discord_webhook_url
    alarms_discord_webhook_url        = local.secrets.alarms_discord_webhook_url
  }

  /*----------------------------------------------------------------------*/
  /* VPC Variables                                                        */
  /*----------------------------------------------------------------------*/

  vpc_parameters = {
    vpc_cidr = local.vpc_cidr
    private_subnets = [
      cidrsubnet(local.vpc_cidr, 4, 0),
      cidrsubnet(local.vpc_cidr, 4, 1),
      cidrsubnet(local.vpc_cidr, 4, 2)
    ]
    public_subnets = [
      cidrsubnet(local.vpc_cidr, 4, 3),
      cidrsubnet(local.vpc_cidr, 4, 4),
      cidrsubnet(local.vpc_cidr, 4, 5)
    ]
    database_subnets = [
      cidrsubnet(local.vpc_cidr, 4, 6),
      cidrsubnet(local.vpc_cidr, 4, 7),
      cidrsubnet(local.vpc_cidr, 4, 8)
    ]
    elasticache_subnets = [
      cidrsubnet(local.vpc_cidr, 4, 9),
      cidrsubnet(local.vpc_cidr, 4, 10),
      cidrsubnet(local.vpc_cidr, 4, 11)
    ]
    elasticache_dedicated_network_acl = false

    default_security_group_ingress = [
      {
        "cidr_blocks" = "0.0.0.0/0",
        "from_port"   = 0,
        "to_port"     = 0,
        "protocol"    = "-1"
      }
    ]
    default_security_group_egress = [
      {
        "cidr_blocks" = "0.0.0.0/0",
        "from_port"   = 0,
        "to_port"     = 0,
        "protocol"    = "-1"
      }
    ]
    enable_nat_gateway         = false
    enable_ec2_nat_gateway     = true
    ec2_nat_gateway_attach_eip = true

  }

  /*----------------------------------------------------------------------*/
  /* route53 Variables                                                    */
  /*----------------------------------------------------------------------*/
  route53_parameters = {
    zones = {
      "${local.zone_public}" = {
        private = false
      }

      "${local.zone_private}" = {
        private = true
      }
    }
  }

}