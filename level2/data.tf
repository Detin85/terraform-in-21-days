data "terraform_remote_state" "level1" {
  backend = "s3"
  
  config = {
    bucket         = "detin-demo-v1"
    key            = "level1/terraform.tfstate"
    region         = "eu-central-1"
  }
}