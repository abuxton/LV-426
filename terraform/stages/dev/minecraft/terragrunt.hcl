include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:darrelldavis/terraform-aws-minecraft.git//ec2_minecraft"
}

# Fill in the variables for that module
inputs = {
  key_name  = "tg_user"
  bucket_id = "lv-426-minecraft"
  vpc_id    = "vpc-6ab4cd02"
  subnet_id = "subnet-e64cc39sc"
}