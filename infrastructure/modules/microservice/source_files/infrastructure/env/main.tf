resource "azuredevops_git_repository_file" "providers_tf" {
  repository_id       = var.reopsitory_id
  file                = "infrastructure/${var.stage_key}/providers.tf"
  content             = templatefile("${path.module}/templates/providers.tftpl", {
    terraform_cloud_organization = var.terraform_cloud_organization
    workspace_name = var.terraform_workspace_name
    azuread_client_id_var_name = var.azuread_client_id_var_name
    azuread_tenant_id_var_name = var.azuread_tenant_id_var_name
  })
  branch              = "refs/heads/main"
  commit_message      = "ci: add terraform provider definition"
  overwrite_on_create = false
}

resource "azuredevops_git_repository_file" "tfcloud_variables_tf" {
  repository_id       = var.reopsitory_id
  file                = "infrastructure/${var.stage_key}/tfcloud_variables.tf"
  content             = templatefile("${path.module}/templates/tfcloud_variables.tftpl", {
    azuread_client_id_var_name = var.azuread_client_id_var_name
    azuread_tenant_id_var_name = var.azuread_tenant_id_var_name
    environment_name_var_name = var.environment_name_var_name
  })
  branch              = "refs/heads/main"
  commit_message      = "ci: add terraform cloud variables definition"
  overwrite_on_create = false
}