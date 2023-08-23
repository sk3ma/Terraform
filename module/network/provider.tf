/*
    TERRAFORM RESOURCE TO CREATE AN VPC RESOURCE.
*/

/* Defining AWS provider */
provider "aws" {
  profile = var.profile
  region  = var.region
  alias   = "ireland"
}
