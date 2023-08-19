/*
    TERRAFORM RESOURCE TO CREATE AN S3 BUCKET.
*/

/* Defining AWS provider */
provider "aws" {
  profile = var.profile
  region  = var.region
  alias   = "ireland"
}
