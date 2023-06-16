/* Defining virtual server */
resource "aws_instance" "myInstance" {
  ami           = var.ami
  instance_type = var.instance
  subnet_id     = aws_subnet.mySubnet.id
  tags = {
    Name = "MyInstance"
	Description = "EC2 instance"
  }
}