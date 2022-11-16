terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.29.1"
    }
  }
}


provider "azurerm" {
  features {}

  # required because we don't have the necessary permissions
  skip_provider_registration = true
}
