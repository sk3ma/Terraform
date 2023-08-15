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

variable "name" {
  description = "The account name."
  type        = string
  default     = "MonthlyBudget"
}

variable "amount" {
  description = "The budget amount."
  type        = string
  default     = "10"
}

variable "begin" {
  description = "The first alert."
  type        = string
  default     = "2023-07-01_00:00"
}

variable "first" {
  description = "The second alert."
  type        = string
  default     = "80"
}

variable "second" {
  description = "The start time."
  type        = string
  default     = "90"
}
