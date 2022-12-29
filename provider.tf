/* Defining provider component */
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}
variable aws_region {}

provider "aws" {
  region = var.aws_region
  alias = "ireland"
}