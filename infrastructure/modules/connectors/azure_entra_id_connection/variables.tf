variable "agent_application_name" {}
variable "azure_tenant_id" {}
variable "azure_msgraph_roles" {
  type    = set(string)
  default = ["Application.ReadWrite.All", "Directory.ReadWrite.All", "AppRoleAssignment.ReadWrite.All"]
}