/* Defining firewall rules */
resource "aws_security_group" "sec_group" {
  name        = "ec2_security_group"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = [80, 443, 8443]
    content {
      description = "Allow EC2 traffic"
      from_port   = tonumber(ingress.key)
      to_port     = tonumber(ingress.key)
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["41.59.72.123/32"]
}

  egress {
    description = "Allow all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySecgrp"
  }
}
