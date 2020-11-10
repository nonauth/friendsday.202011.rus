// Required variables
variable "name" {
  type        = string
  description = "SG name"
}

variable "ingress_rules" {
  type = map(object({
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_blocks = list(string)
  }))

  description = "Map of ingress rules"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

// Optional variables
variable "description" {
  type        = string
  description = ""
  default     = "SG description"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}
