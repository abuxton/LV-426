terraform {
  #backend "s3" {}
  backend "remote" {
    organization = "hc-implementation-services"
    workspaces {
      name = "LV-426"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
