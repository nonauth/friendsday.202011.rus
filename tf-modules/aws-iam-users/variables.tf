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

variable "s3_rw_prefixes" {
  type = list(string)
}

// Optional variables
variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}
