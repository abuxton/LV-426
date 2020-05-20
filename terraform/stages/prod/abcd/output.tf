output "zone_id" {
  value = module.route53.zone_id
}

output "name_servers" {
  value = aws_route53_record.lv-426.records
}
