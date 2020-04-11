terraform {
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
}
locals {
  key_name      = "tg_user"
  bucket_id     = "lv-426-minecraft"
  vpc_id        = "vpc-6ab4cd02"
  subnet_id     = "subnet-e64cc39c"
  mc_version    = "1.15.2" 
}

resource "aws_s3_bucket" "minecraft-bucket" {
  bucket = local.bucket_id
  acl    = "private"

  tags = {
    Name        = local.bucket_id
    Environment = "Dev"
  }
}

module "minecraft" {
  source = "git@github.com:abuxton/terraform-aws-minecraft.git?ref=master"
  module_depends_on = ["${module.minecraft.minecraft-bucket}]
  key_name      = local.key_name
  bucket_id     = local.bucket_id
  vpc_id        = local.vpc_id
  subnet_id     = local.subnet_id
  mc_version    = local.mc_version

}

