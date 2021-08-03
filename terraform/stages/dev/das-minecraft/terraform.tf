terraform {
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
  required_version = ">= 0.13"
  required_providers {
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
    aws = {
      source  = "-/aws"
      version = "~> 3.37.0"
    }
    // aws = {
    //   source  = "hashicorp/aws"
    //   version = "~> 3.37.0"
    // }
  }
}

provider "template" {
  # Configuration options
}
provider "aws" {
  # Configuration options
}
