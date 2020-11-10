// Requirement variables
variable "name" {
  type        = string
  description = "Resource name"
}

variable "iam_path" {
  type        = string
  description = "IAM object path"
}

variable "s3_rw_prefixes" {
  type        = list(string)
  description = "List of WR S3 prefixes"
}


// Optional variables
variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}
