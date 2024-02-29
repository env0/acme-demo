variable "name" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map
  default = {}
}

variable "ebs_size" {
  type    = number
  default = 10
}

variable "security_group_ids" {
  type = list(string)
  default = null
}