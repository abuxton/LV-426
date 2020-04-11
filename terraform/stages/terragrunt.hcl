remote_state {
  backend = "s3"
  config = {
    bucket = "lv-426-terraform-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "lv-426-lock-table"
  }
}
