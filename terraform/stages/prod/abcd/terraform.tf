terraform {
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }

}
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}
