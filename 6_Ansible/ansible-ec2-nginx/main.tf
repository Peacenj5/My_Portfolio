# Create EC2 Instance
resource "aws_instance" "web" {
  ami             = "ami-0604f27d956d83a4d" # Replace with a valid AMI for your region
  instance_type   = "t2.micro"
  key_name        = "DemoEc2Key" # Ensure this key exists in AWS
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3  # Required for Ansible
              EOF

  tags = {
    Name = "WebServer"
  }
}

# Create Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
