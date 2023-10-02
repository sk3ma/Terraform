/* Defining virtual server */
resource "aws_instance" "ec2_instance" {
  ami               = var.ami
  instance_type     = var.instance
  key_name          = aws_key_pair.ec2_ssh_key.key_name
  user_data         = file("provision.sh")
  subnet_id         = aws_subnet.ec2sub.id
  security_groups   = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "EC2Instance"
  }
}
