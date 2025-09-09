module "organization" {

  source = "../../modules/organization"

  /*----------------------------------------------------------------------*/
  /* General Variables                                                    */
  /*----------------------------------------------------------------------*/

  metadata = local.metadata

  /*----------------------------------------------------------------------*/
  /* Organization                                                         */
  /*----------------------------------------------------------------------*/

  organization_parameters = {
    enable_organization = true

    aws_service_access_principals = [
      "cloudtrail.amazonaws.com",
      "sso.amazonaws.com",
      "user-subscriptions.amazonaws.com",
      "ram.amazonaws.com",
      "account.amazonaws.com"
    ]
    feature_set = "ALL"

    organizational_units = {
      "Workload" = {
        ou_policies = {
          "tag-convention"      = {}
          "aws-backup-deletion" = {}
          "governance"          = {}
          "compliance"          = {}
        }
      }
      "Sandbox" = {
        ou_policies = {
          "tag-convention" = {}
          "governance"     = {}
          "compliance"     = {}
        }
      }
      "Infrastructure" = {
        ou_policies = {
          "tag-convention"      = {}
          "aws-backup-deletion" = {}
          "governance"          = {}
          "compliance"          = {}
        }
      }
    }

    accounts = {
      "${local.metadata.public_domain}-prd" = {
        email                             = "aws+prd@democorp.cloud",
        parent_id                         = "Workload",
        allow_iam_users_access_to_billing = true
      }
      "${local.metadata.public_domain}-dev" = {
        email                             = "aws+dev@democorp.cloud",
        parent_id                         = "Workload",
        allow_iam_users_access_to_billing = true
      }
      "${local.metadata.public_domain}-sha" = {
        email                             = "aws+sha@democorp.cloud",
        parent_id                         = "Infrastructure",
        allow_iam_users_access_to_billing = true
      }
      "${local.metadata.public_domain}-lab" = {
        email                             = "aws+lab@democorp.cloud",
        parent_id                         = "Sandbox",
        allow_iam_users_access_to_billing = true
      }
    }
  }

  /*----------------------------------------------------------------------*/
  /* Identity Center                                                      */
  /*----------------------------------------------------------------------*/

  identity_center_parameters = {
    enable_identity_center = true

    identity_users = {
      "${local.metadata.key.company}-user1" = {
        display_name = "Name1 Surname1"
        name = {
          given_name  = "Name1"
          family_name = "Surname1"
        }
        emails = {
          primary = true
          value   = "user1@democorp.cloud"
        }
      }
    }

    identity_groups = {
      "CloudAdministrator" = {
        description = "This group is for users that will have Administrator Access to the different accounts in the Organization"
        users = [
          "${local.metadata.key.company}-user1"
        ]
      },
      "CloudEngineer" = {
        description = "This group is for users that will have Developer access in the different accounts and Administrator Access in the Projects/Laboratory/Sandbox account"
        users = [
        ]
      }
      "CloudTrainee" = {
        description = "This group is for users that will have Developer access in the different accounts and Administrator Access in the Laboratory/Sandbox account"
        users = [
        ]
      }
    }

    identity_permission_sets = {
      "Admin" = {
        inline_policies = {}
        aws_managed_policies = [
          "arn:aws:iam::aws:policy/AdministratorAccess",
          "arn:aws:iam::aws:policy/job-function/Billing"
        ]
        description      = "Administrator and Billing permission Set"
        relay_state      = null
        session_duration = "PT8H"
      }
      "ReadOnly" = {
        inline_policies = {}
        aws_managed_policies = [
          "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
          "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
          "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess",
          "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
          "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
          "arn:aws:iam::aws:policy/AWSLambda_ReadOnlyAccess"
        ]
        description      = "EC2, SQS and Cloudwatch Read Only permission Set"
        relay_state      = "https://us-east-2.console.aws.amazon.com/cloudwatch/"
        session_duration = "PT8H"
      }
    }

    identity_target_accounts = {
      "${local.metadata.public_domain}-prd" = {
        "CloudAdministrator" = {
          permission_set = "Admin"
        }
      }
      "${local.metadata.public_domain}-dev" = {
        "CloudAdministrator" = {
          permission_set = "Admin"
        }
        "CloudEngineer" = {
          permission_set = "ReadOnly"
        }
      }
      "${local.metadata.public_domain}-sha" = {
        "CloudAdministrator" = {
          permission_set = "Admin"
        }
      }
      "${local.metadata.public_domain}-lab" = {
        "CloudAdministrator" = {
          permission_set = "Admin"
        }
        "CloudEngineer" = {
          permission_set = "Admin"
        }
        "CloudTrainee" = {
          permission_set = "Admin"
        }
      }
    }

    # external_identity_groups = [
    #   "External_Group_1",
    # ]

    # external_organization_account_ids = {
    #   "External_Account_1" = "111111111111"
    # }
  }

  /*----------------------------------------------------------------------*/
  /* GitLab                                                               */
  /*----------------------------------------------------------------------*/

}

module "organization_s3_backend" {

  source = "../../modules/organization"

  providers = {
    aws = aws.sha
  }
  /*----------------------------------------------------------------------*/
  /* General Variables                                                    */
  /*----------------------------------------------------------------------*/

  metadata = local.metadata

  /*----------------------------------------------------------------------*/
  /* Organization                                                         */
  /*----------------------------------------------------------------------*/

  s3_backend_parameters = {
    name = "gcl-sha-s3-backend"
    aws_accounts = {
      "root" = { account_id = "111111111111" }
      "prd"  = { account_id = "222222222222" }
      "dev"  = { account_id = "333333333333" }
      "sha"  = { account_id = "444444444444" }
      "lab"  = { account_id = "555555555555" }
    }
  }

}
