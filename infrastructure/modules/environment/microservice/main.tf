module "terraform_workspace" {
  source                     = "../terraform_cloud_workspace"
  microservice_name          = var.name
  microservice_friendly_name = var.friendly_name
  microservice_description   = var.description
  environment                = var.environment
  terraform_cloud-org        = var.terraform_cloud-org
  terraform_cloud_proj_id    = var.terraform_cloud_proj_id
}

module "azure_entra_id_conncetion" {
  source                 = "../../connectors/azure_entra_id_connection"
  agent_application_name = "Managed Terraform Agent Frontend service ${var.name} (Stage ${var.environment.friendly_name})"
  azure_tenant_id        = var.azure_tenant_id
}

resource "tfe_variable" "azure_credentials" {
  key          = "ARM_CLIENT_SECRET"
  value        = module.azure_entra_id_conncetion.agent_application.client_secret
  category     = "env"
  workspace_id = module.terraform_workspace.id
  description  = "Creds for service account ${module.azure_entra_id_conncetion.agent_application.display_name} (App ID ${module.azure_entra_id_conncetion.agent_application.id})"
  sensitive    = true
}

resource "tfe_variable" "terraform_cloud_to_azure_connection_service_account" {
  key          = "terraform_cloud_to_azure_connection_service_account"
  value        = module.azure_entra_id_conncetion.agent_application.id
  category     = "terraform"
  workspace_id = module.terraform_workspace.id
  description  = "App ID for service account ${module.azure_entra_id_conncetion.agent_application.display_name}"
  sensitive    = false
}

resource "tfe_variable" "azure_tenant_id" {
  key          = "azure_tenant_id"
  value        = var.azure_tenant_id
  category     = "terraform"
  workspace_id = module.terraform_workspace.id
  description  = "Azure tenant ID where stage is located on"
  sensitive    = false
}