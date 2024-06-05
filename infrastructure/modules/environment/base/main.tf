resource "google_project" "environment" {
  name            = "JobHive ${var.name}"
  project_id      = "job-hive-${var.gcp_project_postfix == null ? var.short_name : var.gcp_project_postfix}"
  folder_id       = var.gcp_default_project_folder_id
  billing_account = var.gcp_default_billing_account_id
}

locals {
  backend_microservices = {
    for name, microservice in var.microservices : name => microservice
    if(microservice.is_frontend == false || microservice.is_frontend == null) && (microservice.no_infra == null || microservice.no_infra == false)
  }
  frontend_microservices = {
    for name, microservice in var.microservices : name => microservice
    if microservice.is_frontend == true && (microservice.no_infra == null || microservice.no_infra == false)
  }
}

module "frontend_microservice" {
  source        = "../frontend_microservice"
  for_each      = local.frontend_microservices
  key           = each.key
  name          = each.value.name
  friendly_name = each.value.friendly_name
  description   = each.value.description
  environment = {
    name          = var.name
    short_name    = var.short_name
    friendly_name = var.friendly_name
  }
  terraform_cloud-org     = var.terraform_cloud-org
  terraform_cloud_proj_id = var.terraform_cloud_proj_id
  azure_tenant_id         = var.azure_tenant_id
}

module "backend_microservice" {
  source        = "../backend_microservice"
  for_each      = local.backend_microservices
  key           = each.key
  name          = each.value.name
  friendly_name = each.value.friendly_name
  description   = each.value.description
  environment = {
    name          = var.name
    short_name    = var.short_name
    friendly_name = var.friendly_name
  }
  terraform_cloud-org                               = var.terraform_cloud-org
  terraform_cloud_proj_id                           = var.terraform_cloud_proj_id
  azure_tenant_id                                   = var.azure_tenant_id
  terraform_cloud_to_gcp_connection_service_account = var.terraform_cloud_to_gcp_connection_service_account
}

