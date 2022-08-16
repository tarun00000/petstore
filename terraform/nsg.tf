resource "azurerm_network_security_group" "petstore-app-nsg" {
  name                = "petstore-app-nsg"
  location            = azurerm_resource_group.resource-grp-dev.location
  resource_group_name = azurerm_resource_group.resource-grp-dev.name

  security_rule {
    name                       = "nsg-rule-1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

# ## lets retrive data from resource like network security so we can use it later 
data "azurerm_network_security_group" "getNSGID"{
  name                = azurerm_network_security_group.petstore-app-nsg.name
  resource_group_name = azurerm_resource_group.resource-grp-dev.name
  # filter {
  #   name  = "tag:environment"
  #   value  =  ["Production"]
  # }
  # depends_on = [
  #   "azurerm_network_security_group.petstore-app-nsg"
  # ]
}

# ## Log retrived vale
# output "nsg_id"{
#     value = data.azurerm_network_security_group.getNSGID.id
# }
