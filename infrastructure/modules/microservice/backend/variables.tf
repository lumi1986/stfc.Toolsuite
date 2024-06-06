variable "azure_devops_project_id" {}
variable "terraform_cloud_organization" {}
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
variable "environments" {
  type = map(object({
    name                = string
    friendly_name       = string
    description         = string
    gcp_project_postfix = optional(string)
    azure_tenant_id     = string
  }))
}