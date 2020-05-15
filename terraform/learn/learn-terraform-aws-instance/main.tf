terraform {
  backend "remote" {
    hostname     = "hashiqube.io"
    organization = "abc-hashiqube"

    workspaces {
      name = "learn-terraform-aws-instance"
    }
  }
}
