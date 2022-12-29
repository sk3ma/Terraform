variable vpc_cidr_block {}
variable subnet_cidr_block {}
variable avail_zone {}
variable env_prefix {}

/* Defining VPC component */
resource "aws_vpc" "clientVPC" {
  cidr_block = ${var.vpc_cidr_block}
  tags = {
    Name = "${var.env_prefix}-vpc"
	Description = "Client VPC"
  }
}

/* Defining subnet component */
resource "aws_subnet" "clientSubnet" {
  vpc_id = aws_vpc.clientVPC.id
  cidr_block = ${var.subnet_cidr_block}
  availability_zone = ${var.avail_zone}
  tags = {
    Name = "${var.env_prefix}-subnet"
	Description = "Client subnet"
  }
}

/* Defining routing component */
resource "aws_route_table" "clientRTB" {
  vpc_id = aws_vpc.clientVPC.id
  route {
    cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.clientIGW.id
  }
  tags = {
    Name = "${var.env_prefix}-rtb"
	Description = "Routing table"
  }
}

/* Defining gateway component */
resource "aws_internet_gateway" "clientIGW" {
  vpc_id = aws_vpc.clientVPC.id
  tags = {
    Name = "${var.env_prefix}-igw"
	Description = "Internet access"
  }
}

/* Defining association component */
resource "aws_route_table_association" "clientASC" {
  subnet_id = aws_subnet.clientSubnet.id
  route_table_id = aws_route_table.clientRTB.id
  tags = {
    Name = "${var.env_prefix}-associate"
	Description = "Subnet association"
  }
}

/* Defining firewall component */
resource "aws_security_group" "clientSG" {
  name   = "Allowing ports"
  vpc_id = aws_vpc.clientVPC.id

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.client_ip]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
	prefix_list_ids = []
  }
  tags = {
    Name = "${var.env_prefix}-sg"
	Description = "Client firewall"
  }
}