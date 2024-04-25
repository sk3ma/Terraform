/* Defining Terraform provider */
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "remote" {
    organization = "<organization>"
    workspaces {
      name = "<workspace>"
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
