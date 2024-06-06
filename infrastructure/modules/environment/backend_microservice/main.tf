module "microservice" {
  source                  = "../microservice"
  key                     = var.key
  name                    = var.name
  friendly_name           = var.friendly_name
  description             = var.description
  environment             = var.environment
  terraform_cloud-org     = var.terraform_cloud-org
  terraform_cloud_proj_id = var.terraform_cloud_proj_id
  azure_tenant_id         = var.azure_tenant_id
}

module "gcp_connection" {
  source              = "../../connectors/gcp_connection"
  gcp_service_account = var.terraform_cloud_to_gcp_connection_service_account
}

resource "tfe_variable" "google_credentials" {
  key          = "GOOGLE_CREDENTIALS"
  value        = module.gcp_connection.credentials
  category     = "env"
  workspace_id = module.microservice.terraform_workspace_id
  description  = "Creds for service account ${var.terraform_cloud_to_gcp_connection_service_account}"
  sensitive    = true
}