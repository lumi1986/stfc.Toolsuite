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