import {
  to = github_repository.microservices["mitigation_calculator"]
  id = "stfc.MitigationCalculator"
}

resource "github_repository" "microservices" {
  for_each   = var.microservices
  name       = "stfc.${each.value.name}"
  visibility = "public"
}
