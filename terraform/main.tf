# Azure Resource Manager Provider
provider "azurerm" {
  features {}
}
##
/*
# Kubernetes Provider (configured after AKS cluster creation)
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.main.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)
}
*/
# Get available Azure regions/locations
data "azurerm_locations" "available" {
  location = var.region
}
/*
# Local values for consistency
locals {
  cluster_name = var.clusterName
}
*/