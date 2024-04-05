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

provider "aws" {
  region  = var.region
  profile = var.profile
}
