// Required variables
variable "users" {
  type        = map(string)
  description = "Users with passwords"
}

variable "iam_path" {
  type        = string
  description = "IAM object path"
}

variable "common_prefix" {
  type = string
}

// Optional variables
variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}
