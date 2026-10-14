resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_name # Replace with your key pair name
  
  tags = {
    Name        = "web-instance"
    Environment = var.environment
  }
}
