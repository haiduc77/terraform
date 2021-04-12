
provider "azurerm" {
  skip_provider_registration = true
  features {}
  
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location

}

#creating app service plan that we need for the app service itself
resource "azurerm_app_service_plan" "main" {
  name                = "${var.prefix}-asp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name


  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-appservice"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  
site_config {
    dotnet_framework_version = "v4.0"
    }
  
  source_control {
    repo_url = "https://github.com/LUCPO23/test-visma.git"
    branch = "master"
  }
}
resource "azurerm_sql_server" "example" {
  name                         = "${var.prefix}-dbserver"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "adm1n157r470r"
  administrator_login_password = "v3ry-5tr0ng-p455w0rd"
depends_on = [azurerm_resource_group.main]

}
#Using ZRS replication type for HA
resource "azurerm_storage_account" "sg" {
  name                     = "test1lucianvismastorage"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  depends_on = [azurerm_resource_group.main]
}

resource "azurerm_sql_database" "main" {
  name                = "${var.prefix}-db"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  server_name         = azurerm_sql_server.example.name
depends_on = [azurerm_resource_group.main]


}
