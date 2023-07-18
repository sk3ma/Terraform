/* Defining AWS provider */
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

/* Defining network component */
resource "aws_vpc" "myVPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "MyVPC"
    Description = "EC2 private network"
  }
}

/* Defining subnet component */
resource "aws_subnet" "mySubnet" {
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.az
  tags = {
    Name        = "MySubnet"
    Description = "EC2 instance subnet"
  }
}

/* Defining gateway component */
resource "aws_internet_gateway" "myInternetGateway" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name        = "MyIGW"
    Description = "EC2 internet gateway"
  }
}

/* Defining routing component */
resource "aws_route_table" "myRouteTable" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name        = "MyRT"
    Description = "EC2 routing table"
  }
}

resource "aws_route" "myRoute" {
  route_table_id         = aws_route_table.myRouteTable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myInternetGateway.id
  tags = {
    Name        = "MyRoute"
    Description = "EC2 network route"
  }
}

/* Defining association component */
resource "aws_route_table_association" "myRouteTableAssociation" {
  subnet_id      = aws_subnet.mySubnet.id
  route_table_id = aws_route_table.myRouteTable.id
  tags = {
    Name        = "MyRTA"
    Description = "EC2 subnet association"
  }
}

/* Defining firewall component */
resource "aws_security_group" "mySecurityGroup" {
  name        = "instance-security-group"
  description = "Allow SSH, HTTP and HTTPS"
  vpc_id      = aws_vpc.myVPC.id

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

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name        = "MySG"
    Description = "EC2 security group"
  }
}