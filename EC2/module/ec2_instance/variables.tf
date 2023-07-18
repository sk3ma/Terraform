variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for subnet"
  default     = "10.0.0.0/24"
}

variable "az" {
  type        = string
  description = "Availability zone for subnet"
  default     = "eu-west-1a"
}