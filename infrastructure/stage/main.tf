locals {
  workspaces = tomap({
    for workspace in flatten([
      for microservice_key, microservice in var.microservices : [
        for environment_key, environment in var.environments : {
          microservice_key           = microservice_key
          environment_key            = environment_key
          microservice_name          = microservice.name
          microservice_friendly_name = microservice.friendly_name
          environment_name           = environment.name
          environment_friendly_name  = environment.friendly_name
        }
      ]
    ])
    : "${workspace.microservice_key}.${workspace.environment_key}" => workspace
  })
}

resource "azurerm_resource_group" "stfc_toolsuite" {
  name     = "STFC-Toolsuite"
  location = var.resource_location
}

resource "azurerm_container_app_environment" "this" {
  name                = "STFC-Toolsuite-Generic"
  location            = azurerm_resource_group.stfc_toolsuite.location
  resource_group_name = azurerm_resource_group.stfc_toolsuite.name
}