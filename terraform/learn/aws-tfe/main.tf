provider "aws" {
  region = "us-east-1"
}

module "tfe" {
  source = "./forks/is-terraform-aws-tfe-standalone-quick-install"

  friendly_name_prefix     = "my-unique-prefix"
  tfe_hostname             = "my-tfe-instance.whatever.com"
  tfe_license_file_path    = "./tfe-license.rli"
  vpc_id                   = "vpc-00000000000000000"
  alb_subnet_ids           = ["subnet-00000000000000000", "subnet-11111111111111111", "subnet-22222222222222222"] # public subnet IDs
  ec2_subnet_ids           = ["subnet-33333333333333333", "subnet-44444444444444444", "subnet-55555555555555555"] # private subnets IDs
  rds_subnet_ids           = ["subnet-33333333333333333", "subnet-44444444444444444", "subnet-55555555555555555"] # private subnets IDs
  route53_hosted_zone_name = "whatever.com"
}

output "tfe_url" {
  value = module.tfe.tfe_url
}

output "tfe_admin_console_url" {
  value = module.tfe.tfe_admin_console_url
}
