terraform {
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
}
module "route53" {
  source = "git::https://github.com/clouddrove/terraform-aws-route53.git?ref=tags/0.12.0"
  name   = "route53"

  #    application    = "clouddrove"
  environment    = "test"
	comment		 = "Managed by Terraform"
  label_order    = ["environment", "name", "application"]
  public_enabled = true
  record_enabled = true
  domain_name    = "abcdevelopment.co.uk"
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

resource "aws_route53_record" "www" {
  zone_id = module.route53.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = "300"
  records = ["blog.abcdevelopment.co.uk"]
	depends_on = [module.route53.zone_id]
}
resource "aws_route53_record" "mail" {
  zone_id = module.route53.zone_id
  name    = "mail"
  type    = "CNAME"
  ttl     = "300"
  records = ["ghs.googlehosted.com"]
	depends_on = [module.route53.zone_id]
}
resource "aws_route53_record" "blog" {
  zone_id = module.route53.zone_id
  name    = "blog"
  type    = "CNAME"
  ttl     = "300"
  records = ["abuxton.github.io"]
	depends_on = [module.route53.zone_id]
}
## you don't seam to be able to do this with terraform it needs a server dependency based on dns_a_record_set.smtp
## it gets into `Error: update server is not set` issues, manually had to edit state and dynamoDB lock md5 as suggested by error message.
## leaving here for reference.
# resource "dns_mx_record_set" "mx" {
#   zone = "abcdevelopment.co.uk."
#   ttl  = 300

#   mx {
#     preference = 1
#     exchange   = "ASPMX.L.GOOGLE.COM."
#   }

#   mx {
#     preference = 5
#     exchange   = "ALT2.ASPMX.L.GOOGLE.COM."
#   }
#   mx {
#     preference = 5
#     exchange   = "ALT1.ASPMX.L.GOOGLE.COM."
#   }
# 	  depends_on = [
#     "aws_route53_record.mail"
#   ]
# }
