# sandhyavastralayam-web-infra

```text
modules/
  gateway_api/       # API Gateway HTTP API, GET route, and Lambda integration
  lambda_container/  # Image-based Lambda function using an existing ECR image
```

## Lambda container image

The Lambda function uses an image that must already exist in ECR. Terraform
does not create or manage the ECR repository, build the image, or publish it.
Set `lambda_image_uri` in `terraform.tfvars` to the existing image URI, for
example:

```text
409182249189.dkr.ecr.us-east-1.amazonaws.com/gateway-fastapi-ecrrepo@sha256:<digest>
```

The image must be available at that URI before Terraform creates or updates the
function. Lambda container images must be Linux-based and use a supported
single-architecture Docker v2 or OCI image manifest. They must include a
Lambda-compatible runtime interface client or adapter. The configured
`lambda_architecture` (default `x86_64`) must match the image; set it to
`arm64` only for an ARM64 image. Changing the Terraform architecture does not
convert an image.

Apply the Terraform configuration to create or update the Lambda function:

```powershell
terraform apply
```

Terraform exposes the deployed function name and configured image URI as the
`lambda_function_name` and `lambda_image_uri` outputs. If an ECR repository was
previously tracked at `module.lambda_container.aws_ecr_repository.this`,
Terraform detaches it from state without deleting the AWS repository.

The Lambda execution role has basic CloudWatch Logs permissions. Add other
permissions only if the application requires additional AWS services.

The API Gateway module defines an HTTP API with a `GET /` Lambda proxy route.
When enabled, the API forwards the HTTP API payload-format 2.0 request to the
Lambda. The supplied image must package the FastAPI GET endpoint with a
Lambda-compatible runtime or adapter (for example, Lambda Web Adapter) to
handle that event. The Terraform configuration does not create the application
endpoint itself.
