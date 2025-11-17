provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnets" {
  for_each            = var.vnets
  name                = each.value.vnet_name
  address_space       = [each.value.vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.vnets
  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnets[each.key].name
  address_prefixes     = [each.value.subnet_cidr]
}

resource "azurerm_virtual_wan" "main" {
  name                = var.vwan_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
}

resource "azurerm_virtual_hub" "main" {
  name                = var.vwan_hub_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.main.id
  address_prefix      = var.vwan_hub_address_prefix
}

resource "azurerm_virtual_hub_connection" "hub_connections" {
  for_each                  = azurerm_virtual_network.vnets
  name                      = "${each.value.name}-to-vwan-hub"
  virtual_hub_id            = azurerm_virtual_hub.main.id
  remote_virtual_network_id = each.value.id
}