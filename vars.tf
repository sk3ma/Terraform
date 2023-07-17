/* Defining resource variables */
variable "instance_name" {
  type        = string
  description = "Name of the EC2 instance"
  default     = "sandbox"
}

variable "instance_type" {
  type        = string
  description = "Type of instance to be created"
  default     = "t2.micro"
}

variable "ami_id" {
  type        = string
  description = "The AMI to use"
  default     = "ami-066841d983164f7f6"
}

variable "number_of_instances" {
  type        = string
  description = "number of instances to be created"
  default     = 1
}
