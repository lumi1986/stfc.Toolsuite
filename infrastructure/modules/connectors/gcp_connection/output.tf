output "credentials" {
  value = join("", [for line in split("\n", base64decode(google_service_account_key.terraform_service_account_publisher_key.private_key)) : trimspace(line)])
}