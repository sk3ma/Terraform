/* Defining virtual server */
resource "aws_instance" "zabbix_server" {
  ami           = var.ami
  instance_type = var.instance
  key_name      = aws_key_pair.ec2_ssh_key.key_name
  subnet_id     = aws_subnet.zabbix_subnet.id
  user_data     = file("provision.sh")

  tags = {
    Name = "zabbix-server"
  }
}
