/* Defining resource variables */
variable "region" {
  description = "The AWS region."
  type        = string
  default     = "eu-west-1"
}

variable "profile" {
  description = "The AWS profile."
  type        = string
  default     = "playground"
}

variable "backup_bucket_name" {
  description = "Name of the S3 bucket for backups"
  type        = string
  default     = "levon-backup-bucket"
}
