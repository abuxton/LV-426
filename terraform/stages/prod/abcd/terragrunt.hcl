# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#terraform {
#  source = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//asg-elb-service?ref=v0.1.0"
#}
# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

locals {
  # Automatically load environment-level variables
  environment_vars	=	read_terragrunt_config(find_in_parent_folders("env.hcl"))
  key_name      		=  local.environment_vars.locals.key_name #"tg_user"
  vpc_id        		= "vpc-6ab4cd02"
  subnet_id     		= "subnet-e64cc39c"
  # Extract out common variables for reuse
  env 							=	local.environment_vars.locals.environment
	region						= local.environment_vars.locals.region
}
