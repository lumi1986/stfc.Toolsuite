terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.104.2"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.52.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.55.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }

  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "azuread" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

provider "tfe" {
  token = var.terraform_cloud_api_token
}

provider "github" {
  token = var.github_api_token
}