terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.42.0"
    }
  }
}

provider "azurerm" {
  features {}
}
#resource group
resource "azurerm_resource_group" "rg1" {
  name     = "cicdrg"
  location = "East Us"
}
#acr registry
resource "azurerm_container_registry" "acr" {
  name                = "acrbmnn"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  sku                 = "Premium"
  admin_enabled       = false
  georeplications {
    location                = " Central Us"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "East Us2"
    zone_redundancy_enabled = true
    tags                    = {}

  }

}
#azure web app service /service plan 

resource "azurerm_app_service_plan" "asp" {
  name                = "bmnn-appserviceplan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "apps" {
  name                = "bmnn-app-service"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

