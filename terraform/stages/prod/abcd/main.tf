

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
  #  fqdn    = "www.abcdevelopment.co.uk"
  name    = "www"
  type    = "CNAME"
  zone_id = module.route53.zone_id
  alias {
    evaluate_target_health = false
    name                   = "blog.abcdevelopment.co.uk"
    zone_id                = module.route53.zone_id
  }
}
resource "aws_route53_record" "mail" {
  zone_id    = module.route53.zone_id
  name       = "mail"
  type       = "CNAME"
  ttl        = "300"
  records    = ["ghs.googlehosted.com"]
  depends_on = [module.route53.zone_id]
}
resource "aws_route53_record" "blog" {
  zone_id    = module.route53.zone_id
  name       = "blog"
  type       = "CNAME"
  ttl        = "300"
  records    = ["abuxton.github.io"]
  depends_on = [module.route53.zone_id]
}
resource "aws_route53_record" "lv-426" {
  #    fqdn    = "lv-426.abcdevelopment.co.uk"
  #    id      = "Z0987161QT7M8Q43CAL6_lv-426.abcdevelopment.co.uk_NS"
  name = "lv-426.abcdevelopment.co.uk"
  records = [
    "ns-1281.awsdns-32.org",
    "ns-1561.awsdns-03.co.uk",
    "ns-461.awsdns-57.com",
    "ns-882.awsdns-46.net",
  ]
  // records = [
  // "${module.route53.aws_route53_zone.public[0].name_servers.0}",
  // "${module.route53.aws_route53_zone.public[0].name_servers.1}",
  // "${module.route53.aws_route53_zone.public[0].name_servers.2}",
  // "${module.route53.aws_route53_zone.public[0].name_servers.3}",
  // ]
  ttl     = 300
  type    = "NS"
  zone_id = module.route53.zone_id
}

resource "aws_route53_record" "mx" {
  #  fqdn = "abcdevelopment.co.uk"
  #  id   = "Z0987161QT7M8Q43CAL6_abcdevelopment.co.uk_MX"
  name = "abcdevelopment.co.uk"
  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "10 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
  ]
  ttl     = 300
  type    = "MX"
  zone_id = module.route53.zone_id
}
resource "aws_key_pair" "tg_user" {
  # (resource arguments)
  public_key = file("/Users/abuxton/.ssh/tg_user_rsa.pub")
}
