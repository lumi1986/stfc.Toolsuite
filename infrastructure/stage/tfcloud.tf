locals {
  workspaces = tomap({
    for workspace in flatten([
      for microservice_key, microservice in var.microservices : [
        for environment_key, environment in var.environments : {
          microservice_key           = microservice_key
          environment_key            = environment_key
          microservice_name          = microservice.name
          microservice_friendly_name = microservice.friendly_name
          environment_name           = environment.name
          environment_friendly_name  = environment.friendly_name
        }
      ]
    ])
    : "${workspace.microservice_key}.${workspace.environment_key}" => workspace
  })
}

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