provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
}

module "ec2" {
  source = "./modules/ec2"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  environment          = var.environment
  security_group_id    = module.ec2_security_group.security_group_id
  iam_instance_profile = module.ec2_role.instance_profile_name
}

module "ec2_role" {
  source = "./modules/iam/ec2_role"

  role_name   = var.role_name
  environment = var.environment
  policy_arns = var.policy_arns

}

module "ec2_security_group" {
  source = "./modules/vpc"

  security_group_id = var.security_group_id
}
