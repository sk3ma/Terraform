/* Defining region AMI */
data "aws_ami" "amazon-image" {
  most_recent = true
  owners = ["amazon"]
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
variable pubkey_path {}
variable prikey_path {}

resource "aws_key_pair" "clientKEY" {
  key_name = "server-keypair"
  public_key = file(var.pubkey_path)

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
#  user_data = file("../scripts/Packages.sh")
  user_data = <<-STOP
    #!/usr/bin/env bash
    sudo yum update -y
    sudo yum install docker -y
    mkdir -p /container
    echo "<h1>Nginx is operational</h1>" > /container/index.html
    sudo systemctl start docker && sudo systemctl enable docker
    sudo docker volume create bindmount
    sudo docker run --name nginx -p 8080:80 --mount source=bindmount,target=/container nginx
  STOP

/* Defining SSH connection */
connection {
  type = "ssh"
  host = self.public_ip
  user = "ec2-user"
  private_key = file(var.prikey_path)
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
