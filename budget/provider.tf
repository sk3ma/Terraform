/*
    TERRAFORM RESOURCE TO CREATE AN AWS BUDGET.
*/

/* Defining AWS provider */
provider "aws" {
  profile = var.profile
  region  = var.region
  alias   = "ireland"
}
