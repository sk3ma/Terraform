/* Defining virtual server */
resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance
  key_name      = aws_key_pair.ec2_ssh_key.key_name
#  user_data = file("Packages.sh")
  user_data     = <<-STOP
    #!/bin/bash
    sudo apt update
    sudo apt install software-properties-common -y
    sudo apt-add-repository ppa:ansible/ansible -y
    sudo apt install ansible -y
    STOP

  tags = {
    Name = "EC2Instance"
  }
}

# /* Ansible playbook provisioner */
# provider "null" {}
# 
# resource "null_resource" "ansible" {
#   triggers = {
#     timestamp = timestamp()
#   }
# 
#   provisioner "local-exec" {
#     command = "echo 'Running Ansible provisioner'"
#   }
# 
#   provisioner "ansible" {
#     playbook_file = "./playbooks/nginx-install.yml"
#   }
# 
#   provisioner "ansible" {
#     depends_on    = [null_resource.ansible[1]]
#     playbook_file = "./playbooks/nginx-configure.yml"
#   }
# }
