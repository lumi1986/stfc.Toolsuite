data "azuredevops_project" "example" {
  name = "JobHive"
}

resource "azuredevops_git_repository" "ms_repo" {
  count          = var.existing_repository ? 1 : 0
  project_id     = var.azure_devops_project_id
  name           = var.name
  default_branch = "refs/heads/main"
  initialization {
    init_type = "Clean"
  }
  lifecycle {
    ignore_changes = [
      initialization,
    ]
  }
}

resource "azuredevops_git_repository" "ms_repo_import" {
  count          = var.existing_repository ? 0 : 1
  project_id     = var.azure_devops_project_id
  name           = var.name
  default_branch = "refs/heads/main"
  initialization {
    init_type             = "Import"
    source_type           = "Git"
    source_url            = var.import_repo.url
    service_connection_id = var.import_repo.service_connection_id
  }
}