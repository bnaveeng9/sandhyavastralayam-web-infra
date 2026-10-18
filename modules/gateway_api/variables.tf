variable "api_name" {
  description = "Name of the API Gateway HTTP API"
  type        = string
}

variable "function_name" {
  description = "Name of the Lambda function receiving the API requests"
  type        = string
}

variable "function_invoke_arn" {
  description = "Invoke ARN of the Lambda function used for API integration"
  type        = string
}
