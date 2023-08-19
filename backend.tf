terraform {
  backend "s3" {
    bucket = "terraform-state-s3-eu-central-1"
    key = "terraform/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
  }
} 