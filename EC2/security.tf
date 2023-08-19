/* Defining firewall component */
resource "aws_security_group" "ec2_sg" {
  name        = "instance-security-group"
  description = "Allow SSH, HTTP and HTTPS"
  vpc_id      = aws_vpc.ec2_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_instance.my_instance.private_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_instance.my_instance.private_ip]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_instance.my_instance.private_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "MySG"
    Description = "EC2 security group"
  }
}
