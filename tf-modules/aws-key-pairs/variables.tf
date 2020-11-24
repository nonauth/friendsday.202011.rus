variable public_keys {
  type = map(string)
}

variable prefix {
  type    = string
  default = ""
}

variable tags {
  type    = map(string)
  default = {}
}
