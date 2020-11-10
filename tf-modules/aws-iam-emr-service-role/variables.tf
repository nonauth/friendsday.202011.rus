// Required variables
variable "name" {
  type        = string
  description = "Resource name"
}

variable "iam_path" {
  type        = string
  description = "IAM object path"
}


// Optional variables
variable "policy_arn" {
  type        = string
  description = "EMR policy arn"
  default     = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}
