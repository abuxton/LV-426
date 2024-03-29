
locals {
  key_name   = "tg_user"
  bucket_id  = "lv-426-minecraft-bucket"
  vpc_id     = "vpc-6ab4cd02"
  subnet_id  = "subnet-e64cc39c"
  mc_version = "1.15.2"
  mc_root    = "/opt/minecraft/vanilla"
  mc_ami     = "ami-0b1912235a9e70540"
}

resource "aws_s3_bucket" "b" {
  bucket = local.bucket_id
  acl    = "private"
  #region = "eu-west-2"
  tags = {
    Name        = local.bucket_id
    Environment = "Dev"
  }
}


module "minecraft" {
  source     = "git@github.com:abuxton/terraform-aws-minecraft.git?ref=master"
  key_name   = local.key_name
  bucket_id  = local.bucket_id
  vpc_id     = local.vpc_id
  subnet_id  = local.subnet_id
  mc_version = local.mc_version
  mc_root    = local.mc_root
  ami        = local.mc_ami
}

data "template_file" "ssh_config" {
  # count = "${length(module.minecraft.public_ip[0])}"
  template = file("./templates/ssh_config.tmpl")
  vars = {
    count = length(module.minecraft.public_ip)
    ip    = module.minecraft.public_ip[0]
  }
}

// data "template_file" "bolt_inventory" {
//   # count = "${length(module.minecraft.public_ip[0])}"
//   template = "${file("./templates/bolt_inventory.tmpl")}"
//   vars = {
//     count = "${length(module.minecraft.public_ip)}"
//     ip    = "${module.minecraft.public_ip[0]}"
//   }
// }




# a comment for no reason
