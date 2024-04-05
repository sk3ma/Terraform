resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance
  key_name      = aws_key_pair.ssh_key.key_name
  subnet_id     = aws_subnet.subnet.id
  
  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install software-properties-common  -y
              apt-add-repository ppa:ansible/ansible -y
              apt install ansible -y
              EOF

  tags = {
    Name = "ec2"
  }
}
