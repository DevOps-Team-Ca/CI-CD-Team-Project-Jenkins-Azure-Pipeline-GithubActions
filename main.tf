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
  name     = var.resource_group_name
  location = var.resource_group_location
}
#acr registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  sku                 = "Premium"
  admin_enabled       = true
  georeplications {
    location                = " Central Us"
    zone_redundancy_enabled = false
    tags                    = {}
  }
  georeplications {
    location                = "East Us2"
    zone_redundancy_enabled = false
    tags                    = {}
  }
}
#azure web app service 
resource "azurerm_app_service" "apps" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  app_service_plan_id = azurerm_app_service_plan.asp.id


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


# app service plan

resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Free F1"
    size = "S1"
  }
}


