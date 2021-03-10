module "route53" {
  source = "git::https://github.com/clouddrove/terraform-aws-route53.git?ref=tags/0.12.0"
  #source = "git::https://github.com/clouddrove/terraform-aws-route53.git?ref=0.14"
  name = "route53"

  #    application    = "clouddrove"
  environment    = "test"
  comment        = "Managed by Terraform"
  label_order    = ["environment", "name", "application"]
  public_enabled = true
  record_enabled = true
  domain_name    = "example.com"
  names = [
    "prod.",
    "dev."
  ]
  types = [
    "A",
    "CNAME"
  ]
  tags = {
    ManagedBY = "Terraform",
  }
}
