variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-default-bucket"
}

variable "environment" {
  description = "The environment for the S3 bucket"
  type        = string
  default     = "dev"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Example AMI ID
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key pair name for the EC2 instance"
  type        = string
  default     = "sirikeypair"
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "my-iam-role"
}

variable "policy_arns" {
  description = "A list of IAM policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

variable "security_group_id" {
  description = "The source security group allowed to reach the EC2 security group"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function deployed from the ECR image"
  type        = string
}

variable "lambda_architecture" {
  description = "Instruction set architecture used by the Lambda container image"
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.lambda_architecture)
    error_message = "lambda_architecture must be either x86_64 or arm64."
  }
}

variable "gateway_api_name" {
  description = "Name of the API Gateway HTTP API"
  type        = string
  default     = "gateway-fastapi-api"
}


variable "lambda_image_uri" {
  description = "URI of an existing Lambda container image in ECR"
  type        = string
  default     = "409182249189.dkr.ecr.us-east-1.amazonaws.com/gateway-fastapi-ecrrepo@sha256:eefd13562e94011893197afbe07a7ab25d868f886fb6393ea9fa80e9075c397b"
}