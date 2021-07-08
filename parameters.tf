terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.13.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = var.SUB_ID
  client_id       = var.CLI_ID
  client_secret   = var.CLI_SECRET
  tenant_id       = var.TEN_ID  
}