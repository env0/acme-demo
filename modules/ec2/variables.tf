variable "name" {
  type    = string
}

variable "instance_count" {
  type    = number
}

variable "instance_type" {
  type    = string
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map
}

variable "ebs_size" {
  type    = number
  default = 10
}