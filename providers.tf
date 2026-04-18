provider "aws" {
  region = "us-east-1"
}

##store state file locally
terraform {
  backend "local" {
    path = "/home/ubuntu/terraform/terraform.tfstate"
  }
}
# Ref: https://developer.hashicorp.com/terraform/language/backend/local