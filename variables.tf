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
