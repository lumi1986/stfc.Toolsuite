module "repository" {
  source                  = "../repository"
  name                    = var.name
  azure_devops_project_id = var.azure_devops_project_id
  existing_repository     = var.existing_repository
  import_repo             = var.base_repo
}