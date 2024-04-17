/* Defining virtual server */
resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2_instance" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true
  
  user_data = templatefile("userdata.tpl")
  tags = {
    Name = "ec2"
  }
}
