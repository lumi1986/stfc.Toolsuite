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