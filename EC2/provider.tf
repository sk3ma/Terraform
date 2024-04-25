/*
    TERRAFORM RESOURCE TO CREATE AN EC2 RESOURCE.
*/

/* Defining Terraform provider */
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

/* State file placement */
#terraform {
#  backend "s3" {
#    bucket = "statebucket"
#    key    = "infra"
#    region = "eu-west-1"
#  }
#}

/* State file placement */
# terraform {
#   backend "remote" {
#     organization = "<organization>"
#     workspaces {
#       name = "<workspace>"
#     }
#   }
# }

/* Defining AWS provider */
provider "aws" {
#  shared_credentials_file = "~/.aws/credentials"
  region                  = var.region
#  profile                 = var.profile
  alias                   = "ireland"
}
