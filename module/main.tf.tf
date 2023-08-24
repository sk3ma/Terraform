/*
    TERRAFORM MODULE TO CREATE AN EC2 RESOURCE.
*/

provider "aws" {
  region = "eu-west-1"
  profile = "playground"  
}

module "instance" {
  source = "./instance"

/* Instance module variables */
  instance_ami      = "ami-066841d983164f7f6"
  instance_type     = "t2.micro"
  vpc_id            = module.network.vpc_id
  aws_region        = "us-east-1"
  aws_profile       = "your_aws_profile"
}

module "network" {
  source = "./network"

/* VPC module variables */
  availability_zone = eu-west-1a"
  aws_region        = "eu-west-1"
  aws_profile       = "playground"
}
