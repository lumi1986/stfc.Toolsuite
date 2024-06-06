data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "msgraph" {
  application_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing   = true
}

resource "azuread_application" "managed_terraform_agent" {
  display_name = var.agent_application_name

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    dynamic "resource_access" {
      for_each = var.azure_msgraph_roles
      content {
        id   = azuread_service_principal.msgraph.app_role_ids[resource_access.value]
        type = "Role"
      }
    }
  }
}

resource "azuread_application_password" "managed_terraform_agent_password" {
  application_object_id = azuread_application.managed_terraform_agent.id
}

resource "azuread_service_principal" "managed_terraform_agent_principal" {
  application_id = azuread_application.managed_terraform_agent.application_id
}

resource "azuread_app_role_assignment" "msgraph_application_readwrite_all" {
  for_each            = var.azure_msgraph_roles
  app_role_id         = azuread_service_principal.msgraph.app_role_ids[each.value]
  principal_object_id = azuread_service_principal.managed_terraform_agent_principal.object_id
  resource_object_id  = azuread_service_principal.msgraph.object_id
}