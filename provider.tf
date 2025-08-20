terraform {

  backend "s3" {

    bucket         = "detin-demo-v1"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-remote-state"
    encrypt        = true
  }
}


provider "aws" {
  region = "eu-central-1"
}