/* S3 state file */
terraform {
  backend "s3" {
    bucket = var.bucket
    key    = var.key
    region = var.region
  }
}

