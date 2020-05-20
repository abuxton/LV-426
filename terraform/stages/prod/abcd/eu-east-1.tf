provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}
resource "aws_key_pair" "tg_user_east" {
  provider = aws.us-east-1
  # (resource arguments)
  public_key = file("/Users/abuxton/.ssh/tg_user_rsa.pub")
}
