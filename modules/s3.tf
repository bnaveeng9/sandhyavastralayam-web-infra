module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}
