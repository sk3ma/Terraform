/* Defining network component */
resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

/* Defining subnet component */
resource "aws_subnet" "ec2sub" {
  count                   = 1
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "EC2 and RDS instance"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
