variable "name" {
  type    = string
  default = "env0-acme-ec2"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "t3a.nano"
}

variable "ssh_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}