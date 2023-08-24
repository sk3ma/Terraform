/* Defining virtual server */
resource "aws_instance" "wordpress" {
  ami                         = var.ami
  count                       = var.number_of_instances
  instance_type               = var.instance_type
  key_name                    = "keypair"
  subnet_id                   = aws_subnet._public_subnet.id
  security_groups_ids         = [aws_security_group._sg.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.tpl")

  tags = {
    Name = "Wordpress_EC2"
  }
}
