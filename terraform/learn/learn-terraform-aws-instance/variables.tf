# variables
variable "region" {
  default = "us-east-1"
}
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

variable "name" {
  default = null
}

variable "prefix" {
  default = "dev"
}
