/* Defining resource variables */
variable "region" {
  type        = string
  description = "The AWS region"
  default     = "eu-west-1"
}

variable "profile" {
  description = "The AWS profile"
  type        = string
  default     = "playground"
}

variable "instance" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "ami" {
  type        = string
  description = "Ubuntu 20.04 Ireland"
  default     = "ami-066841d983164f7f6"
}

variable "az" {
  type        = string
  description = "Subnet availability zone"
  default     = "eu-west-1a"
}
