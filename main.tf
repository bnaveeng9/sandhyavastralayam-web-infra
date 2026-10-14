provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "./modules"

  bucket_name = var.bucket_name
  environment = var.environment
}
