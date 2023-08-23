/*
    TERRAFORM RESOURCE TO CREATE AN EC2 RESOURCE.
*/

/* Defining AWS provider */
provider "aws" {
  profile = var.profile
  region  = var.region
  alias   = "ireland"
}

/* Using SSH key */
resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
