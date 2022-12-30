/* Defining region AMI */
data "aws_ami" "amazon-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64.gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  tags = {
    Name = "${var.env_prefix}-ami"
    Description = "Region AMI"
  }
}

/* Defining SSH key */
variable public_key_location = {}

resource "aws_key_pair" "clientKEY" {
  key_name = "server-keypair"
  public_key = file(var.public_key_location)

/* Defining virtual server */
variable ec2_type {}

resource "aws_instance" "clientEC2" {
  ami = data.aws_ami.amazon-image.id
  instance_type = var.ec2_type
  subnet_id = aws_subnet.clientSubnet.id
  vpc_security_group_ids = [aws_security_group.clientSG.id]
  availability_zone = var.avail_zone
  associate_public_ip_address = true
  key_name = aws_key_pair.clientKEY_key_name
#  user_data = file("/tmp/Packages.sh")
  user_data = <<-STOP
    #!/usr/bin/env bash
    sudo yum update -y
    sudo yum install docker -y
    sudo usermod -aG docker ec2-user
    mkdir -p /container
    echo "<h1>Nginx is operational</h1>" > /container/index.html
    sudo systemctl start docker
    sudo systemctl enable docker
    docker volume create bindmount
    docker run --name nginx -p 8080:80 --mount source=bindmount,target=/container nginx
  STOP

  /* Defining SSH connection */
connection {
  type = "ssh"
  host = self.public_ip
  user = "ec2-user"
  private_key = file(var.private_key_path)
}

/* Defining server provisioner */
provisioner "file" {
  source = "Packages.sh"
  destination = "/tmp/Packages.sh"
}
  tags = {
    Name = "${var.env_prefix}-ec2"
    Description = "Client server"
  }
}
