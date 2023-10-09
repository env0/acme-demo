locals {
  myMap = {"a" = {name="a"}, "b" = {name="b"}, "c" = {name="c"}, "d" = {name="d"}, "e" = {name="e"}, "f" = {name="f"}}
}

module randomStrings {
  for_each = local.myMap

  source = "../../modules/random"

  refresh_token = each.value.name
}

output name {
  value = module.randomStrings[*]
}
