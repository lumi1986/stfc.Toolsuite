resource "time_rotating" "rotation" {
  rotation_days = 30
}

resource "google_service_account_key" "terraform_service_account_publisher_key" {
  service_account_id = var.gcp_service_account
  keepers = {
    rotation_time = time_rotating.rotation.rotation_rfc3339
  }
}