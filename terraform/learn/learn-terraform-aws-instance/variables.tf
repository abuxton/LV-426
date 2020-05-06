# variables
variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}
variable "aws_access_key_id" {
  default = null
}
variable "aws_secret_access_key" {
  default = null
}

variable "region" {
  description = "This is the cloud hosting region where your webapp will be deployed."
  default     = "us-east-1"
}

variable "prefix" {
  description = "This is the environment your webapp will be prefixed with. dev, qa, or prod"
}

variable "name" {
  description = "Your name to attach to the webapp address"
}
