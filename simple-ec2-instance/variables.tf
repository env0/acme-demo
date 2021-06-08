variable "name" {
  type    = string
  default = "env0-acme-ec2"
}

variable "instance_count" {
  type    = number
  default = 3
}

variable "instance_type" {
  type    = string
  default = "t3.xlarge"
}
