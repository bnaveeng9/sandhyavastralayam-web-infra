instance_type = "t2.micro"
ami_id        = "ami-091138d0f0d41ff90" # Example AMI ID
key_name      = "sirikeypair"           # Replace with your key pair name
bucket_name   = "my-test-bucket-409182249189"
environment   = "prod"
role_name     = "MyAmazonSSMReadOnlyAccess1"
policy_arns = [
  "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
  "arn:aws:iam::aws:policy/AmazonSESFullAccess",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
  "arn:aws:iam::409182249189:policy/CaddyRoute53DNSChallengePolicy"
]
security_group_id    = "sg-09cc7c3bde64e1e97"
lambda_function_name = "gateway-fastapi-lambdafunction1"
gateway_api_name     = "gateway-fastapi-api"
lambda_image_uri     = "409182249189.dkr.ecr.us-east-1.amazonaws.com/gateway-fastapi-ecrrepo@sha256:eefd13562e94011893197afbe07a7ab25d868f886fb6393ea9fa80e9075c397b"