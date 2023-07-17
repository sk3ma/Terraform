/* Defining AWS provider */
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

  backend "http" {
  }
}

provider "aws" {
  shared_credentials_file = "/home/levon/.aws/credentials"
  profile                 = "default"
  region                  = "eu-west-1"
}

/* AWS EC2 resource */
resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  count                       = var.number_of_instances
  instance_type               = var.instance_type
  key_name                    = "mykeypair"
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install apache2 -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "<h1>Deployed using Terraform</h1>" > /var/www/html/index.html
  EOF
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  tags = {
    Name        = "My_EC2"
    Description = "EC2 virtual server"
  }
}

/* AWS VPC resource */
resource "aws_vpc" "ec2_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "My_VPC"
    Description = "EC2 custom VPC"
  }
}

/* Defining network component */
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.ec2_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "VPC_public"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.ec2_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "VPC_private"
  }
}

resource "aws_internet_gateway" "ec2_ig" {
  vpc_id = aws_vpc.ec2_vpc.id

  tags = {
    Name = "VPC_IGW"
  }
}

resource "aws_route_table" "ec2_public_rt" {
  vpc_id = aws_vpc.ec2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.ec2_ig.id
  }

  tags = {
    Name = "VPC_RT"
  }
}

resource "aws_route_table_association" "ec2_public_1_rt_a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.ec2_public_rt.id
}

/* Defining firewall component */
resource "aws_security_group" "ec2_sg" {
  name        = "HTTP, HTTPS and SSH"
  description = "EC2 security group"
  vpc_id      = aws_vpc.ec2_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "My_SG"
    Description = "EC2 security group"
  }
}
