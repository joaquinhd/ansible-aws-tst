provider "azurerm" {}

resource "azurerm_resource_group" "main" {
  name      = "main-resources"
  location  = "West Europe"
}

resource "azurerm_virtual_network" "main" {
    name                =   "mf-network"
    address_space       =   ["10.0.0.0/16"]
    location            =   "${azurerm_resource_group.main.location}"
    resource_group_name =   "${azurerm_resource_group.main.name}"
}

resource "azurerm_subnet" "internal" {
    name                    =   "internal"
    resource_group_name     =   "${azurerm_resource_group.main.name}"
    virtual_network_name    =   "${azurerm_virtual_network.main.name}"
    address_prefix          =   "10.0.2.0/24"
}

resource "azurerm_postgresql_server" "mfpostgresql" {
  name                    =     "mfpostgresql"
  location                =     "${azurerm_resource_group.main.location}"
  resource_group_name     =     "${azurerm_resource_group.main.name}"
  
  sku {
    name     = "GP_Gen5_2"
    capacity = 2
    tier     = "GeneralPurpose"
    family   = "Gen5"
  }
  
  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
    auto_grow             = "Enabled"
  }

  administrator_login          = "azadmin"
  administrator_login_password = "4ll_un33d1Sl0v3"
  version                      = "9.5"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_postgresql_virtual_network_rule" "main" {
  name                                 = "postgresql-vnet-rule"
  resource_group_name                  = "${azurerm_resource_group.main.name}"
  server_name                          = "${azurerm_postgresql_server.mfpostgresql.name}"
  subnet_id                            = "${azurerm_subnet.internal.id}"
  ignore_missing_vnet_service_endpoint = true
}