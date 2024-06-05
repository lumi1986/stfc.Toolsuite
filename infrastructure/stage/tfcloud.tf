locals {
  workspaces = flatten([
    for microservice_key, microservice in war.microservices : [
      for environment_key, environment in var.environments : {
        microservice_key = microservice_key
        environment_key  = environment_key
        microservice_name = microservice.name
        microservice_friendly_name = microservice.friendly_name
        environment_name = environment.name
        environment_friendly_name = environment.friendly_name
      }
    ]
  ])
}