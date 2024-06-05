module "repository" {
  source                  = "../repository"
  name                    = var.name
  azure_devops_project_id = var.azure_devops_project_id
  existing_repository     = var.existing_repository
  import_repo             = var.base_repo
}

module "infrastructure_env_sources" {
  source = "../source_files/infrastructure/env"
  for_each = var.environments
  stage_key = each.key
  reopsitory_id = module.repository.id
  terraform_cloud_organization = var.terraform_cloud_organization
  terraform_workspace_name = "JobHive_${var.name}_${each.value.name}"
  azuread_client_id_var_name = "terraform_cloud_to_azure_connection_service_account"
  azuread_tenant_id_var_name = "azure_tenant_id"
  environment_name_var_name = "environment_name"
}