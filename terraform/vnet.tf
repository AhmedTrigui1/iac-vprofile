module "vnet" {
  source  = "Azure/network/azurerm"
  version = "5.3.0"  

  resource_group_name = azurerm_resource_group.vprofile.name
  location            = "germanywestcentral"
  vnet_name           = "vprofile-aks-vnet"
  address_space       = ["172.20.0.0/16"]

  # Subnets (adjusted for Azure/AKS best practices)
  subnet_names    = ["private-subnet-1", "private-subnet-2", "public-subnet-1", "public-subnet-2"]
  subnet_prefixes = ["172.20.1.0/24", "172.20.2.0/24", "172.20.4.0/24", "172.20.5.0/24"]

  # Azure-specific networking features
  enable_network_watcher          = false  # Disable if not needed
  create_network_security_group   = true   # Recommended for AKS

  # Tags for AKS integration
  tags = {
    environment = "prod"
  }

  # AKS-specific subnet tags (replaces AWS EKS tags)
  subnet_service_endpoints = {
    "private-subnet-1" = ["Microsoft.ContainerRegistry", "Microsoft.Storage"],
    "private-subnet-2" = ["Microsoft.ContainerRegistry", "Microsoft.Storage"]
  }
}

# Required resource group
resource "azurerm_resource_group" "vprofile" {
  name     = "oratio-onboarding-ahmed-imen-rg"
  location = "germanywestcentral"
}

# NAT Gateway
resource "azurerm_public_ip" "nat" {
  name                = "vprofile-nat-pip"
  location            = azurerm_resource_group.vprofile.location
  resource_group_name = azurerm_resource_group.vprofile.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "main" {
  name                = "vprofile-nat"
  location            = azurerm_resource_group.vprofile.location
  resource_group_name = azurerm_resource_group.vprofile.name
  sku_name            = "Standard"
}

# Associate NAT with private subnets
resource "azurerm_subnet_nat_gateway_association" "private1" {
  subnet_id      = module.vnet.vnet_subnets[0]  # private-subnet-1
  nat_gateway_id = azurerm_nat_gateway.main.id
}

resource "azurerm_subnet_nat_gateway_association" "private2" {
  subnet_id      = module.vnet.vnet_subnets[1]  # private-subnet-2
  nat_gateway_id = azurerm_nat_gateway.main.id
}