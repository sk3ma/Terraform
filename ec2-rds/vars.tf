/* Defining resource variables */
variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "profile" {
  description = "The AWS profile"
  type        = string
  default     = "playground"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "wordpress_ec2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "ami" {
  description = "The Ireland Ubuntu AMI"
  type        = string
  default     = "ami-066841d983164f7f6"
}

variable "db_name" {
  description = "The Wordpress database name"
  type        = string
  default     = "wordpress_db"
}

variable "db_user" {
  description = "The Wordpress username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The Wordpress password"
  type        = string
  default     = "1q2w3e4r5t"
}
