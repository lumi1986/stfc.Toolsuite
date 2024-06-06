output "id" {
  value = var.existing_repository ? azuredevops_git_repository.ms_repo[0].id : azuredevops_git_repository.ms_repo_import[0].id
}