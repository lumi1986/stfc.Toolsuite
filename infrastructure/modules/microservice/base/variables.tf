variable "azure_devops_project_id" {}
variable "terraform_cloud_organization" {}
variable "microservices" {
  type = map(object({
    name                = string
    friendly_name       = string
    description         = string
    is_frontend         = optional(bool)
    existing_repository = optional(bool)
  }))
}
variable "microservice_base_repos" {
  type = object({
    frontend_service_connection_id = string
    frontend_url                   = string
    backend_service_connection_id  = string
    backend_url                    = string
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