variable "azure_devops_project_id" {}
variable "key" {}
variable "name" {}
variable "friendly_name" {}
variable "description" {}
variable "existing_repository" {
  type = bool
}
variable "base_repo" {
  type = object({
    url                   = string
    service_connection_id = string
  })
}