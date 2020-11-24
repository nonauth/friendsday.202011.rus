// Required variables
variable "s3_buckets" {
  description = "AWS S3 bucket objects"
  type = map(object({
    prefix = string
    acl    = string
    tags   = map(string)
  }))
}

variable "force_destroy" {
  type        = bool
  default     = true
  description = "Allow force destroy buckets"
}

// Optional variables
variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
