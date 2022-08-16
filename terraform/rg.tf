resource "azurerm_resource_group" "resource-grp-dev" {
  name     = var.resource_grp
  location = var.location
}