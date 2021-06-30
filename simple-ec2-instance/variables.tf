variable "name" {
  type    = string
  default = "env0-acme-ec2"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type    = string
  default = "t3a.large"
}

variable "default_vpc" {
  type    = bool
  default = true
}
variable "vpc_id" {
  type = string
}
