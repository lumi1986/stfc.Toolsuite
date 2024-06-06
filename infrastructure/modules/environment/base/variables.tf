variable "name" {}
variable "friendly_name" {}
variable "short_name" {}
variable "description" {}
variable "gcp_project_postfix" {
  type    = string
  default = null
}
variable "gcp_default_billing_account_id" {}
variable "gcp_default_project_folder_id" {}
variable "azure_tenant_id" {}
variable "terraform_cloud_to_gcp_connection_service_account" {}

variable "terraform_cloud-org" {}
variable "terraform_cloud_proj_id" {}

variable "microservices" {
  type = map(object({
    name          = string
    friendly_name = string
    description   = string
    is_frontend   = optional(bool)
    no_infra      = optional(bool)
  }))
}
