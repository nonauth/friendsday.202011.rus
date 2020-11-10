variable "user_count" {
  type        = number
  description = "Count of users"
}

variable "password_length" {
  type        = number
  description = "Password length"
  default     = 16
}

variable "use_lower" {
  type        = bool
  description = "Using symbols in password"
  default     = true
}

variable "use_number" {
  type        = bool
  description = "Using symbols in password"
  default     = false
}

variable "use_special" {
  type        = bool
  description = "Using symbols in password"
  default     = false
}

variable "use_upper" {
  type        = bool
  description = "Using symbols in password"
  default     = true
}
