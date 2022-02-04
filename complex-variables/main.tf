
# resource "local_file" "randomstring" {
#     content     = random_string.random.result
#     filename = "/tmp/49f45071-9ea0-41fb-a36b-768f703a79c9/randomstring.txt"
# }

variable "mybool" {
  type = bool
}

variable "mylist" {
  type = list(string)
}

variable "mymap" {
  type = map
}

//resource "null" "resource" {}

output "mybool" {
  value = var.mybool
}

output "mylist" {
  value = var.mylist
}

output "mymap" {
  value = var.mymap
}