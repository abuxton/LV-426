terraform {
  backend "s3" {}

# module "ec2_minecraft" {
#   source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git?ref=master"
# }
# module "ec2_security_group" {
#   source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git?ref=master"
# }
#module "minecraft"  {
#  source = "git@github.com:darrelldavis/terraform-aws-minecraft.git"
#}