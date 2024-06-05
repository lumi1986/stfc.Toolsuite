variable "key" {}
variable "name" {}
variable "friendly_name" {}
variable "description" {}
variable "environment" {
  type = object({
    name          = string
    short_name    = string
    friendly_name = string
  })
}
variable "terraform_cloud-org" {}
variable "terraform_cloud_proj_id" {}

variable "azure_tenant_id" {}