data "detin-demo-v1" "level1" {
  backend = "s3"
  
  config = {
    bucket         = "detin-demo-v1"
    key            = "level1.tfstate"
    region         = "eu-central-1"
  }
}