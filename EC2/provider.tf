/*
    TERRAFORM RESOURCE TO CREATE AN EC2 RESOURCE.
*/

/* Defining AWS provider */
provider "aws" {
#  shared_credentials_file = "~/.aws/credentials"
  region                  = var.region
#  profile                 = var.profile
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  alias                   = "ireland"
}
