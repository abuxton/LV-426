terraform {
  backend "remote" {
    organization = "abc-hashi-training"

    workspaces {
      name = "learn_hashicorp_com"
    }
  }
}
