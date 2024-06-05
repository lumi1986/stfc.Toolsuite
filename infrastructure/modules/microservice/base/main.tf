locals {
  backend_microservices = {
    for name, microservice in var.microservices : name => microservice
    if microservice.is_frontend == false || microservice.is_frontend == null
  }
  frontend_microservices = {
    for name, microservice in var.microservices : name => microservice
    if microservice.is_frontend == true
  }
}


module "backend_microservice" {
  source                  = "../backend"
  for_each                = local.backend_microservices
  key                     = each.key
  name                    = each.value.name
  friendly_name           = each.value.friendly_name
  description             = each.value.description
  existing_repository     = each.value.existing_repository != null ? each.value.existing_repository : false
  azure_devops_project_id = var.azure_devops_project_id
  base_repo = {
    url                   = var.microservice_base_repos.backend_url
    service_connection_id = var.microservice_base_repos.backend_service_connection_id
  }
  environments = var.environments
  terraform_cloud_organization = var.terraform_cloud_organization
}

module "frontend_microservice" {
  source                  = "../frontend"
  for_each                = local.frontend_microservices
  key                     = each.key
  name                    = each.value.name
  friendly_name           = each.value.friendly_name
  description             = each.value.description
  existing_repository     = each.value.existing_repository != null ? each.value.existing_repository : false
  azure_devops_project_id = var.azure_devops_project_id
  base_repo = {
    url                   = var.microservice_base_repos.backend_url
    service_connection_id = var.microservice_base_repos.backend_service_connection_id
  }
}