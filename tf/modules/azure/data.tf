// Retrieve information about the pre-existing resource group
data "azurerm_resource_group" "main" {
  name = var.az_resource_group
}
