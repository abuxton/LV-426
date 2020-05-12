############################################################################
# PROVIDER
############################################################################
provider "aws" {
  region  = "us-east-1"
  profile = "tg_user"
}

############################################################################
# PREREQS INFRA - SINGLE REGION
############################################################################

module "tfe-prereqs-primary" {
  source = "./forks/is-terraform-aws-tfe-standalone-prereqs"

  # --- Common --- #
  friendly_name_prefix = var.friendly_name_prefix
  common_tags = {
    "Environment" = "tfe-prereqs-primary"
    "Tool"        = "Terraform"
    "Owner"       = "abuxton"
  }

  # --- Network --- #
  deploy_vpc           = true
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.255.0/24", "10.0.254.0/24", "10.0.253.0/24"]

  # --- Bastion --- #
  deploy_bastion             = true
  bastion_keypair            = aws_key_pair.tg_user.key_name
  bastion_ingress_cidr_allow = ["1.2.3.4/32"]

  # --- S3 --- #
  deploy_bootstrap_bucket = true
  bootstrap_bucket_name   = "${var.friendly_name_prefix}-tfe-bootstrap-primary"

  # --- KMS --- #
  deploy_kms = true

  # --- Secrets Manager --- #
  deploy_secretsmanager      = true
  secretsmanager_secret_name = "tfe-bootstrap-secrets-metadata"
  console_password           = "ProtectThisSecretBetter123!"
  enc_password               = "DefinitelyProtectThisOne456$"
}

resource "aws_key_pair" "tg_user" {
  key_name   = "tg_user"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDScU6TKV3udzpFP9b5LhEp+pl6gp5XuFsAmwzGoElWAGP+rFCojnt+QdJXpQgS2VDcMKcVXAuWhYBnxBByyADaIKF2/QsIxXl1ZobQbOh4cy63lm81FJib1wWtSJOtDxJyHmuegnpN6PV30Tz1lbjXQwGkd0oHKnEzapQnLFmL6bcuUftFBO4xLpv7Jk9TcTBVntrnsXoiB0UA88T5euCTUp7EDExveDawpGcgS2lXo8LEA7ZmuAYnCepPN1OsfxscIDxSnQqYNj/W+B6EC7WBplOhZgCmFbSeR79SAfUfocqbOwyVH2IeevQf39KMe1R75NCLxgyBaQY4vquQwlwwdbe353QsjyzhvpNalcEzTHPew8fO2vpWyyEWa/ftEEAOlsmOk9XC0ZzqJMOuvDobqvdDCHmrDL7Wh3/jLyqYmdT+jdGQIXdnZT7b/83mqpUtJESXvzQhXMm5uxL9hzVvROLcYpukIGMXzGyRnqF3XB6H0QgU4QEOLYfu/q+YrLqhc0qq+df3tXis/tUZEwYbU43pdGbOIVIEXhvse24UjFmww+FyuiwvsQ3TKMwM96FWJwlT/hQqC+GF2hcrHQHn7MsCFXuLgsjQNffQjo3a5Zb9o7Xtj6JK+wVj0rIbiiqDWJvpOlJ5UzuDPOd3wmkbQ0fUy2DlThWy3WbdMIyQxQ== buxton.adam+tg_user@gmail.com"
}
