variable "microservice_name" {}
variable "microservice_friendly_name" {}
variable "microservice_description" {}
variable "environment" {
  type = object({
    name          = string
    short_name    = string
    friendly_name = string
  })
}
variable "terraform_cloud-org" {}
variable "terraform_cloud_proj_id" {}