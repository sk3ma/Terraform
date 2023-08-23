/* Defining resource variables */
variable "region" {
  type        = string
  description = "The AWS region"
  default     = "eu-west-1"
}

variable "profile" {
  description = "The AWS profile."
  type        = string
  default     = "playground"
}

variable "az" {
  type        = string
  description = "EC2 availability zone"
  default     = "eu-west-1a"
}
