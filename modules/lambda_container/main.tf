data "aws_iam_policy_document" "lambda_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "execution" {
  name               = "${var.function_name}-execution"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_ecr_image" "latest" {
  repository_name = "gateway-fastapi-ecrrepo"
  most_recent     = true
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = aws_iam_role.execution.arn
  package_type  = "Image"
  image_uri     = data.aws_ecr_image.latest.image_uri
  architectures = [var.architecture]

  depends_on = [aws_iam_role_policy_attachment.basic_execution]
  timeout     = 5
  
  image_config {
    entry_point = [""]
    command     = ["fastapi_lambdadocker:app, --host, 0.0.0.0, --port, 8080"]
    working_directory = ""
  }


  tags = {
    Environment = var.environment
  }
}

resource "aws_lambda_function_url" "this" {
  function_name = aws_lambda_function.this.function_name
  authorization_type = "NONE"

  # Optional CORS configuration
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["GET", "POST"]
    allow_headers     = ["date", "keep-alive", "content-type"]
    max_age           = 86400
  }

  invoke_mode = "RESPONSE_STREAM"
  
}