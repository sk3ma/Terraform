/* Defining network component */
resource "aws_vpc" "ec2_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "MyVPC"
    Description = "EC2 private network"
  }
}

/* Defining subnet component */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.ec2_vpc.id
  cidr_block              = var.vpc_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true
  tags = {
    Name        = "MySubnet"
    Description = "EC2 instance subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.ec2_vpc.id
  cidr_block        = var.vpc_cidr
  availability_zone = var.az
}

/* Defining routing component */
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.ec2_vpc.id
  tags = {
    Name        = "MyRT"
    Description = "EC2 routing table"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id              = aws_subnet.public_subnet.id
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ec2_igw.id
  tags = {
    Name        = "MyRoute"
    Description = "EC2 network route"
  }
}

resource "aws_internet_gateway" "ec2_igw" {
  vpc_id = aws_vpc.ec2_vpc.id
  tags = {
    Name        = "MyIGW"
    Description = "EC2 internet gateway"
  }
}
