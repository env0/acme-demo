variable "name" {
  type    = string
  default = "env0-acme-ec2"
}

variable "instance_type" {
  type    = string
  default = "t3a.small"
  description = "The ec2 instance size"
}

variable "vpc_id" {
  type = string
}

variable "ebs_size" {
  type    = number
  default = 10
}
