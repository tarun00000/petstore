###############################################
###############################################



resource "azurerm_virtual_network" "vnet-petstore" {
  name                = "vnet-petstore"
  location            = azurerm_resource_group.resource-grp-dev.location
  resource_group_name = azurerm_resource_group.resource-grp-dev.name
  address_space       = var.vnet_cidr_range  

#   subnet {
#     name           = var.subnet_names[1]
#     address_prefix = var.subnet_prefixes[1]
#     security_group = azurerm_network_security_group.petstore-app-nsg.id
#   }

  tags = local.tags
}

data "azurerm_virtual_network" "getVNETID"{
  name                = azurerm_virtual_network.vnet-petstore.name
  resource_group_name = azurerm_resource_group.resource-grp-dev.name
}

resource "azurerm_subnet" "petstore-subnet-web" {
  name                 = var.subnet_names[0]
  resource_group_name  = azurerm_resource_group.resource-grp-dev.name
  virtual_network_name = azurerm_virtual_network.vnet-petstore.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "petstore-subnet-database" {
    name           = var.subnet_names[1]
    resource_group_name  = azurerm_resource_group.resource-grp-dev.name
    virtual_network_name = azurerm_virtual_network.vnet-petstore.name
    address_prefixes = ["10.0.0.0/24"]
  }

resource "azurerm_subnet_network_security_group_association" "petstore-web-nsg-association" {
  subnet_id                 = azurerm_subnet.petstore-subnet-web.id
  network_security_group_id = azurerm_network_security_group.petstore-app-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "petstore-database-nsg-association" {
  subnet_id                 = azurerm_subnet.petstore-subnet-database.id
  network_security_group_id = azurerm_network_security_group.petstore-app-nsg.id
}

resource "azurerm_network_interface" "petstore-nic" {
  name                = "petstore-nic"
  location            =  azurerm_resource_group.resource-grp-dev.location
  resource_group_name =  azurerm_resource_group.resource-grp-dev.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.petstore-subnet-web.id
    private_ip_address_allocation = "Dynamic"
  }
}



# module "vnet-main"{
#     depends_on          = [azurerm_resource_group.resource-grp-dev]
#     source              =   "Azure/vnet/azurerm"
#     resource_group_name =   azurerm_resource_group.resource-grp-dev.name
#     vnet_location       =   azurerm_resource_group.resource-grp-dev.location
#     vnet_name           =   "vnet-petstore"
#     address_space       =   var.vnet_cidr_range
#     subnet_prefixes     =   var.subnet_prefixes
#     subnet_names        =   var.subnet_names
#     # nsg_ids             =   {var.subnet_names[0] = data.azurerm_network_security_group.getNSGID.id}

#     tags = {
#         environment =   "dev"
#         costcenter  =   "it"
#     }
# }



output "vnet_id"{
    value = azurerm_virtual_network.vnet-petstore.id
}

## OR 

# # Create a virtual network within the resource group
# resource "azurerm_virtual_network" "example" {
#   name                = "example-network"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   address_space       = ["10.0.0.0/16"]
# }


# ${} , looks like not used any more after .12 version. You can use depends on instead of it
# you need to create an implicit dependency like this:
# In this way, Terraform knows that it will need to create the Resource Group first before it can create the vNet.
# https://stackoverflow.com/questions/51933811/creating-a-resource-group-with-terraform-in-azure-cannot-find-resource-group-di