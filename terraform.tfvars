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
security_group_id = "sg-09cc7c3bde64e1e97"