terraform {
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.60.0"
    }
  }
}
