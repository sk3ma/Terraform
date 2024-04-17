resource "aws_security_group" "sec_group" {
  name        = "ec2_security_group"
  description = "Allow inbound traffic on ports 80 and 443"
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = ["80, 443, 8080, 8443"]
    content {
      description = "Allow EC2 traffic"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_clocks = ["0.0.0.0/0"]
  }
}

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_clocks = ["10.0.0.0/16"]
}

  egress {
    description = "Allow all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "secgrp"
  }
}
