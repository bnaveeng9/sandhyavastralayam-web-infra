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

