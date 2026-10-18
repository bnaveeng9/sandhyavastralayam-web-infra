# output "gateway_api_url" {
#   description = "Base URL of the HTTP API; send a GET request to this URL"
#   value       = module.gateway_api.api_endpoint
# }

output "lambda_function_name" {
  description = "Name of the container-based Lambda function"
  value       = module.lambda_container.function_name
}

output "lambda_image_uri" {
  description = "Resolved immutable ECR image URI configured for Lambda"
  value       = module.lambda_container.image_uri
}
