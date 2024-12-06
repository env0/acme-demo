resource "azurerm_linux_virtual_machine" "vm" {
  name                = "myVM"
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [
  ]

  #admin_ssh_key {
  #  username   = "azureuser"
  #  public_key = file("~/.ssh/id_rsa.pub")
  #}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}
