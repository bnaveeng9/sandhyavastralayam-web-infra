variable "function_name" {
  description = "Name used for the Lambda function and execution role"
  type        = string
}

variable "environment" {
  description = "Environment tag applied to AWS resources"
  type        = string
}

variable "architecture" {
  description = "Instruction set architecture used by the Lambda container image"
  type        = string

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "architecture must be either x86_64 or arm64."
  }
}
variable "lambda_image_uri" {
  description = "URI of an existing Lambda container image in ECR"
  type        = string
}