variable "name" {
  type    = string
  default = "env0-agent-server"
}

variable "instance_type" {
  type    = string
  default = "t3a.small"
}

variable "vpc_id" {
  type = string
}

variable "ebs_size" {
  type    = number
  default = 50
}