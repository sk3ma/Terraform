/* Defining project variables */
variable "aws_access_key" {
  type        = string
  description = "AWS access key"
  default     = <insert-access-key>
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
  default     = <insert-seret-key>
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}

variable "instance" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami" {
  type        = string
  description = "AMI ID for Ubuntu 20.04 Ireland"
  default     = "ami-066841d983164f7f6"
}

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
