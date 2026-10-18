output "function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "function_invoke_arn" {
  description = "Invoke ARN used by API Gateway"
  value       = aws_lambda_function.this.invoke_arn
}

output "image_uri" {
  description = "Resolved immutable ECR image URI configured for Lambda"
  value       = aws_lambda_function.this.image_uri
}
