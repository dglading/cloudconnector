variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = "
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "dglading-vwan-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vwan_name" {
  description = "Name of the VWAN"
  type        = string
  default     = "dglading-vwan"
}

variable "vwan_hub_name" {
  description = "Name of the VWAN Hub"
  type        = string
  default     = "dglading-vWan-hub"
}

variable "vwan_hub_address_prefix" {
  description = "Address prefix for the vWAN hub"
  type        = string
  default     = "10.0.0.0/23"
}

variable "vnets" {
  description = "Map of virtual networks, each with a map of name, cidr, and next hop bypass flag"
  type = map(object({
    vnet_name                  = string
    subnet_name                = string
    vnet_cidr                  = string
    subnet_cidr                = string
  }))
  default = {
    spoke1 = {
      vnet_name                  = "dglading-spoke1-vnet"
      subnet_name                = "dglading-spoke1-subnet"
      vnet_cidr                  = "10.3.0.0/20"
      subnet_cidr                = "10.3.1.0/24"
    }
    spoke2 = {
      vnet_name   = "dglading-spoke2-vnet"
      subnet_name = "dglading-spoke2-subnet"
      vnet_cidr   = "10.4.0.0/20"
      subnet_cidr = "10.4.1.0/24"
    }
    zscaler = {
      vnet_name   = "dglading-zscaler-vnet"
      subnet_name = "dglading-zscaler-subnet"
      vnet_cidr   = "10.5.0.0/20"
      subnet_cidr = "10.5.1.0/24"
      bypass_next_hop_ip_enabled = true      # Set true ONLY for this VNet
    }
  }
}
