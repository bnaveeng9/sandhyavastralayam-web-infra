variable "role_name" {
  type        = string
  default     = ""
  description = "The name of the IAM role"
}

variable "environment" {
  type        = string
  description = "The environment for the IAM role"
}

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "A list of IAM policy ARNs to attach to the role"
}