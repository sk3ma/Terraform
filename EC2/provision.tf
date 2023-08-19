/* Copy Ansible role */
resource "null_resource" "copy_ansible_role" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "cp -R nginx roles/"
  }
}

/* Ansible role execution */
resource "null_resource" "provision_with_ansible" {
  depends_on = [null_resource.copy_ansible_role, aws_instance.my_instance]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${aws_instance.my_instance.public_ip},' -u ubuntu -b -e 'ansible_python_interpreter=/usr/bin/python3' main.yml"
  }
}
