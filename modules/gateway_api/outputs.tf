output "api_endpoint" {
  description = "Base invoke URL for the HTTP API; GET / invokes the Lambda function"
  value       = aws_apigatewayv2_api.this.api_endpoint
}

output "api_id" {
  description = "ID of the API Gateway HTTP API"
  value       = aws_apigatewayv2_api.this.id
}
