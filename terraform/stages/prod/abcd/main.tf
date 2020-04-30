terraform {
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
}
locals {
  key_name      = "tg_user"
  vpc_id        = "vpc-6ab4cd02"
  subnet_id     = "subnet-e64cc39c"
}
