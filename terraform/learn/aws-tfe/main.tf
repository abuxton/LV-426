############################################################################
# VERSIONS
############################################################################

terraform {
  required_version = "~> 0.12.6"
  backend "remote" {
    organization = "abc-hashi-training"

    workspaces {
      name = "aws-tfe"
    }
  }

  required_providers {
    aws      = "~> 2.58.0"
    template = "~> 2.1.2"
  }
}
