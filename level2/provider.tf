terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.16"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "detin-demo-v1"
    key            = "level2.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-remote-state"
  }
}

provider "aws" {
  region = "eu-central-1"
}