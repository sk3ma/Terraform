/*
    TERRAFORM RESOURCE TO CREATE WORDPRESS.
*/

/* Defining AWS provider */
provider "aws" {
  shared_config_files      = "/home/levon/.aws/config"
  shared_credentials_files = "/home/levon/.aws/credentials"
  profile                  = var.profile
  region                   = var.region
  alias                    = "ireland"
}
