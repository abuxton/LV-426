config {
  module = true
  force = false

  #aws_credentials = {
  #  access_key = "AWS_ACCESS_KEY"
  #  secret_key = "AWS_SECRET_KEY"
  #  region     = "us-east-1"
  #}

  #ignore_module = {
  #  "github.com/terraform-linters/example-module" = true
  #}

  #varfile = ["example1.tfvars", "example2.tfvars"]

  #variables = ["foo=bar", "bar=[\"baz\"]"]
}

plugin "aws" {
  enabled = true
  deep_check = true
}
rule "terraform_module_pinned_source" {
  enabled = false
  style = "flexible"
}
