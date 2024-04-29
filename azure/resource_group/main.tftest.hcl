run "test-variable-inputs" {
  variables {
    prefix = "foo"
    location = "us-east"
    last_updated = "2024-04-29"
  }

  assert {
    condition     = azurerm_resource_group.example.location == "us-east"
    error_message = "rg location not us-east"
  }

  assert {
    condition     = azurerm_resource_group.example.name == "foo-sales-rg"
    error_message = "Resource group name is not foo-sales-rg"
  }
}