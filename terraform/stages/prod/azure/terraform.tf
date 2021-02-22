terraform {
  #backend "s3" {}
  backend "remote" {
    organization = "abc-hashi-training"
    workspaces {
      name = "LV-426-azure"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}
