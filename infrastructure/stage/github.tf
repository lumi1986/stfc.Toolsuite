resource "github_repository" "microservices" {
  for_each = var.microservices
  name        = "stfc.${each.value.name}"
  visibility = "public"
}