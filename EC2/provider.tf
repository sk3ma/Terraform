/*
    TERRAFORM RESOURCE TO CREATE AN EC2 RESOURCE.
*/

/* State file placement */
#terraform {
#  backend "s3" {
#    bucket = "statebucket"
#    key    = "infra"
#    region = "eu-west-1"
#  }
#}

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
