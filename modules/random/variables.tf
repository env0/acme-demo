variable "refresh_token" {
  type    = string
  default = "0"
}

variable "length" {
  type    = number
  default = 5
}

variable "special" {
  type    = bool
  default = false
}

variable "numeric" {
  type    = bool
  default = true
}

variable "upper" {
  type    = bool
  default = false
}

variable "lower" {
  type    = bool
  default = true
}

variable "override_special" {
  type    = string
  default = "-._~"
}