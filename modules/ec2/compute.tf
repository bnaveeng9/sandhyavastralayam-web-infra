resource "aws_instance" "web" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  iam_instance_profile = var.iam_instance_profile

  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name        = "web-instance"
    Environment = var.environment
  }
}
