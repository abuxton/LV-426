# provider "aws" {
# region = "us-east-1"
# }

module "tfe" {
  source = "./forks/is-terraform-aws-tfe-standalone-quick-install"

  friendly_name_prefix     = var.friendly_name_prefix
  tfe_hostname             = "tfe.${var.friendly_name_prefix}.${var.route53_hosted_zone_name}"
  tfe_license_file_path    = "./tfe-license.rli"
  vpc_id                   = module.tfe-prereqs-primary.vpc_id
  alb_subnet_ids           = module.tfe-prereqs-primary.private_subnet_ids # public subnet IDs
  ec2_subnet_ids           = module.tfe-prereqs-primary.private_subnet_ids # private subnets IDs
  rds_subnet_ids           = module.tfe-prereqs-primary.private_subnet_ids # private subnets IDs
  route53_hosted_zone_name = var.route53_hosted_zone_name
}
