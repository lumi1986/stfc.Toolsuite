resource "tfe_workspace" "microservice" {
  depends_on        = [github_repository.microservices]
  for_each          = local.workspaces
  name              = "${each.value.microservice_name}_${each.value.environment_name}"
  organization      = var.terraform_cloud_org
  project_id        = var.terraform_cloud_proj_id
  working_directory = "infrastructure/stage"
  vcs_repo {
    branch                     = "main"
    identifier                 = "lumi1986/${github_repository.microservices[each.value.microservice_key].name}"
    github_app_installation_id = var.terraform_cloud_github_app_id
  }
}

resource "tfe_variable" "client_id" {
  for_each     = local.workspaces
  key          = "client_id"
  value        = azuread_application.terraform_cloud_workspace_agent[each.key].client_id
  category     = "terraform"
  workspace_id = tfe_workspace.microservice[each.key].id
  description  = "Azure Client ID of application registration used as agent representing this workspace"
  sensitive    = false
}

resource "tfe_variable" "client_secret" {
  for_each     = local.workspaces
  key          = "client_secret"
  value        = azuread_application_password.terraform_cloud_workspace_agent_password[each.key].value
  category     = "terraform"
  workspace_id = tfe_workspace.microservice[each.key].id
  description  = "Azure Client secret of application registration used as agent representing this workspace"
  sensitive    = true
}

resource "tfe_variable" "subscription_id" {
  for_each     = local.workspaces
  key          = "subscription_id"
  value        = var.subscription_id
  category     = "terraform"
  workspace_id = tfe_workspace.microservice[each.key].id
  description  = "ID of azure subscription ressources in this project are placed inside"
  sensitive    = false
}

resource "tfe_variable" "tenant_id" {
  for_each     = local.workspaces
  key          = "tenant_id"
  value        = var.tenant_id
  category     = "terraform"
  workspace_id = tfe_workspace.microservice[each.key].id
  description  = "ID of azure tenant ressources in this project are placed inside"
  sensitive    = false
}

resource "tfe_variable" "tenant_id" {
  for_each     = local.workspaces
  key          = "tenant_id"
  value        = var.tenant_id
  category     = "terraform"
  workspace_id = tfe_workspace.microservice[each.key].id
  description  = "ID of azure tenant ressources in this project are placed inside"
  sensitive    = false
}

resource "tfe_variable" "tenant_id" {
  for_each     = local.workspaces
  key          = "tenant_id"
  value        = var.tenant_id
  category     = "terraform"
  workspace_id = tfe_workspace.microservice[each.key].id
  description  = "ID of azure tenant ressources in this project are placed inside"
  sensitive    = false
}

resource "tfe_variable" "container_app_environment_id" {
  for_each     = local.workspaces
  key          = "tenant_id"
  value        = azurerm_container_app_environment.this.id
  category     = "terraform"
  workspace_id = tfe_workspace.microservice[each.key].id
  description  = "ID of azure container app environment"
  sensitive    = false
}

resource "tfe_variable" "resource_group_id" {
  for_each     = local.workspaces
  key          = "resource_group_id"
  value        = azurerm_resource_group.stfc_toolsuite.id
  category     = "terraform"
  workspace_id = tfe_workspace.microservice[each.key].id
  description  = "ID of default azure ressource group"
  sensitive    = false
}