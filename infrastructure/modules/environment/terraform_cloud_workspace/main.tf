resource "tfe_workspace" "microservice" {
  name         = "JobHive_${var.microservice_name}_${var.environment.name}"
  organization = var.terraform_cloud-org
  project_id   = var.terraform_cloud_proj_id
  working_directory = "infrastructure/${var.environment.short_name}"
}

resource "tfe_variable" "environment_name" {
  key          = "environment_name"
  value        = var.environment.name
  category     = "terraform"
  workspace_id = tfe_workspace.microservice.id
  description  = "Name of stage workspace adresses"
  sensitive    = false
}

resource "tfe_variable" "environment_friendly_name" {
  key          = "environment_friendly_name"
  value        = var.environment.friendly_name
  category     = "terraform"
  workspace_id = tfe_workspace.microservice.id
  description  = "Friendly Name of stage workspace adresses"
  sensitive    = false
}