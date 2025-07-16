
/*
# Local values for consistency
locals {
  cluster_name = var.clusterName
}

# Azure AKS Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                = local.cluster_name
  location            = azurerm_resource_group.vprofile.location
  resource_group_name = azurerm_resource_group.vprofile.name
  dns_prefix          = "${local.cluster_name}-dns"
  kubernetes_version  = "1.27"

  # Network configuration
  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.0.0.0/16"
    dns_service_ip = "10.0.0.10"
  }

  # Default node pool (equivalent to your first node group)
  default_node_pool {
    name           = "nodegroup1"
    node_count     = 2
    min_count      = 1
    max_count      = 3
    vm_size        = "Standard_B2s"  # Cost-effective equivalent to t3.small
    vnet_subnet_id = module.vnet.vnet_subnets[0]  # private-subnet-1
    
  }

  # System-assigned managed identity
  identity {
    type = "SystemAssigned"
  }

  # Enable API server access from public internet
  api_server_access_profile {
    authorized_ip_ranges = ["0.0.0.0/0"]  # Allow all IPs - adjust as needed
  }

  tags = {
    Environment = "practice"
    Project     = "vprofile"
  }
}

# Additional node pool (equivalent to your second node group)
resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  name                  = "nodegroup2"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size              = "Standard_B2s"  # Cost-effective equivalent to t3.small
  node_count           = 1
  min_count            = 1
  max_count            = 2
  vnet_subnet_id       = module.vnet.vnet_subnets[1]  # private-subnet-2


  # Use spot instances for cost savings (optional)
  # priority = "Spot"
  # eviction_policy = "Delete"
  # spot_max_price = -1

  tags = {
    Environment = "practice"
    Project     = "vprofile"
  }
}
*/