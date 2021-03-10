terraform {
  #backend "s3" {}
  backend "remote" {
    organization = "hc-implementation-services"
    workspaces {
      name = "LV-426"
    }
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "random" {
  # Configuration options
}
