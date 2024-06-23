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

data "azurerm_subscription" "this" {
}

resource "azuread_application" "terraform_cloud_workspace_agent" {
  for_each     = local.workspaces
  display_name = "TerraformCloud_${each.value.microservice_name}_${each.value.environment_name}"
}

/*resource "azuread_service_principal" "sp" {
  client_id = azuread_application.managed_terraform_agent.client_id
}

resource "azurerm_role_assignment" "read_access_exauto" {
  scope                = "/subscriptions/${data.azurerm_subscription.this.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.sp.object_id
}*/