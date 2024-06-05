output "agent_application" {
  value = {
    id            = azuread_application.managed_terraform_agent.application_id
    display_name  = azuread_application.managed_terraform_agent.display_name
    client_secret = azuread_application_password.managed_terraform_agent_password.value
  }
}