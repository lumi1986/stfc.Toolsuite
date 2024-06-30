environments = {
  local_debug = {
    name          = "LocalDebug"
    friendly_name = "Local Debug Environment"
    description   = "Environment for local develeopment and debugging. Mostly the machine of a developer itself"
    is_virtual    = "true"
  }
  dev = {
    name          = "Dev"
    friendly_name = "Cloud development Environment"
    description   = "Envrionment with fully integration in a technical manner, buth without anny guarantee of up and running state and just including test data"
  }
}

microservices = {
  "mitigation_calculator" = {
    name          = "MitigationCalculator"
    friendly_name = "Microservice Mitigation Calculator"
    description   = "Backend microservice able to calculate mitigation values"
  }
}