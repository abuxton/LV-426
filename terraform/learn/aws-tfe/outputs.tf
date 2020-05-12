output "vpc" {
  value = module.tfe-prereqs-primary.vpc_id
}

output "public_subnet_ids" {
  value = module.tfe-prereqs-primary.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.tfe-prereqs-primary.private_subnet_ids
}

output "bootstrap_bucket_name_primary" {
  value = module.tfe-prereqs-primary.bootstrap_bucket_name
}

output "bastion_public_ip" {
  value = module.tfe-prereqs-primary.bastion_public_ip
}

output "kms_key_arn" {
  value = module.tfe-prereqs-primary.kms_key_arn
}

output "secretsmanager_secret_metadata_arn" {
  value = module.tfe-prereqs-primary.secretsmanager_secret_arn
}
