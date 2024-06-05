variable "microservices" {
  type = map(object({
    name                = string
    friendly_name       = string
    description         = string
    is_frontend         = optional(bool)
  }))
}

variable "environments" {
  type = map(object({
    name                = string
    friendly_name       = string
    description         = string
  }))
}