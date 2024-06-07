resource "github_repository" "microservices" {
  for_each = var.microservices
  name        = "stfc.${each.value.Name}"
  visibility = "public"
}