/* Defining network component */
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Wordpress_VPC"
  }
}

/* Defining subnet component */
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "private_subnet2"
  }
}

/* Defining routing component */
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_routing"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id        = aws_subnet.public_subnet.id
  route_table_id   = aws_route_table.public_rt.id
}
