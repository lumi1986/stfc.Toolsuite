variable "azure_devops_project_id" {}
variable "name" {}
variable "existing_repository" {
  type = bool
}
variable "import_repo" {
  type = object({
    url                   = string
    service_connection_id = string
  })
}