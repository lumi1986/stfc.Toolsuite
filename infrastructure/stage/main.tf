resource "azurerm_resource_group" "stfc_toolsuite" {
  name     = "STFC-Toolsuite"
  location = var.resource_location
}

/*resource "azurerm_container_app_environment" "example" {
  name                       = "Example-Environment"
  location                   = azurerm_resource_group.stfc_toolsuite.location
  resource_group_name        = azurerm_resource_group.stfc_toolsuite.name
}*/