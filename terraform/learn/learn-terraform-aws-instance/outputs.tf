output "ip" {
  value = aws_eip.ip.public_ip
}
output "website_endpoint" {
  value = module.s3-webapp.endpoint
}
