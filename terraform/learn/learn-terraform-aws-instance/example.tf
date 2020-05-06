provider "aws" {
  region  = var.region
  version = "~> 2.60"
}

resource "aws_instance" "example" {
  ami           = var.amis[var.region]
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ip_address.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
  }

}
resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id

}

module "s3-webapp" {
  source  = "app.terraform.io/abc-hashi-training/s3-webapp/aws"
  version = "1.0.0"
  name    = var.name
  region  = var.region
  prefix  = var.prefix
}
