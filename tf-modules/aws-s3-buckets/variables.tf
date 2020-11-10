// Required variables
variable "s3_buckets" {
  description = "AWS S3 bucket objects"
  type = map(object({
    prefix = string
    acl    = string
    tags   = map(string)
  }))
}


// Optional variables
variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
