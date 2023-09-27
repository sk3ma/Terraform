/* Defining network component */
resource "aws_vpc" "zabbix_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "zabbix_subnet" {
  vpc_id                  = aws_vpc.zabbix_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = "zabbix-subnet"
  }
}

/* Defining firewall component */
resource "aws_security_group" "zabbix_security_group" {
  name        = "zabbix-security-group"
  description = "Zabbix server security group"
  vpc_id      = aws_vpc.zabbix_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_instance.zabbix_server.private_ip]
  }

  ingress {
    from_port   = 10051
    to_port     = 10051
    protocol    = "tcp"
    cidr_blocks = [aws_instance.zabbix_server.private_ip]
  }
}
