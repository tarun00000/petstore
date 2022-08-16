resource "tls_private_key" "pet-store-pub_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "tls_private_key" {
  value     = tls_private_key.pet-store-pub_key.private_key_pem
  sensitive = true
}

resource "azurerm_linux_virtual_machine" "petstore-vm" {
  depends_on = [ azurerm_virtual_network.vnet-petstore , azurerm_network_interface.petstore-nic]
  name                = "petstore-vm"
  resource_group_name = azurerm_resource_group.resource-grp-dev.name
  location            = azurerm_resource_group.resource-grp-dev.location
  size                = "Standard_F2"
  admin_username      = "petvm"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.petstore-nic.id
  ]

  tags = local.tags

  admin_ssh_key {
    username   = "petvm"
    public_key = tls_private_key.pet-store-pub_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  # user_data = <<EOF
  # #! /bin/bash
  # ls -al
  # echo "Install Kind"
  # echo "setup k8s and app"
  # EOF

}