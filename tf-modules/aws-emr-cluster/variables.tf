// Required variables
variable "emr_managed_master_security_group" {
  type        = string
  description = ""
}

variable "emr_managed_slave_security_group" {
  type        = string
  description = ""
}

variable "instance_profile" {
  type        = string
  description = ""
}

variable "name" {
  type        = string
  description = ""
}

variable "service_role" {
  type        = string
  description = ""
}

variable "subnet_id" {
  type        = string
  description = ""
}


// Optional variables
variable "applications" {
  type        = list(string)
  description = ""
  default = [
    "Spark",
    "Hive",
    "Hadoop",
    "JupyterHUB",
  ]
}

variable "bootstrap_actions" {
  type = map(object({
    path = string
    args = list(string)
  }))

  description = ""
  default     = {}
}

variable "core_ebs_size" {
  type        = number
  description = ""
  default     = 200
}

variable "core_ebs_type" {
  type        = string
  description = ""
  default     = "gp2"
}

variable "core_instance_count" {
  type        = number
  description = ""
  default     = 2
}

variable "core_instance_type" {
  type        = string
  description = ""
  default     = "t3.xlarge"
}

variable "core_volumes_per_instance" {
  type        = number
  description = ""
  default     = 1
}

variable "ebs_root_valume_size" {
  type        = number
  description = ""
  default     = 200
}

variable "keep_job_flow_alive_when_no_steps" {
  type        = bool
  description = ""
  default     = true
}

variable "master_instance_count" {
  type        = number
  description = ""
  default     = 1
}

variable "master_instance_type" {
  type        = string
  description = ""
  default     = "t3.xlarge"
}

variable "release_label" {
  type        = string
  description = ""
  default     = "emr-5.31.0"
}

variable "tags" {
  type        = map(string)
  description = ""
  default     = {}
}

variable "termination_protection" {
  type        = bool
  description = ""
  default     = false
}
