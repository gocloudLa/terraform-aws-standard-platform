module "security" {

  source = "../../modules/security"

  providers = {
    aws.org = aws
    aws.sec = aws
    aws.log = aws
    aws.kms = aws
  }

  /*----------------------------------------------------------------------*/
  /* General Variables                                                    */
  /*----------------------------------------------------------------------*/

  metadata = local.metadata

  /*----------------------------------------------------------------------*/
  /* CloudTrail                                                           */
  /*----------------------------------------------------------------------*/

  cloudtrail_parameters = {}

}