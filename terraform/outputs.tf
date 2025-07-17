/*output "cluster_name" {
  description = "Azure Kubernetes Service (AKS) Cluster Name"
  value       = azurerm_kubernetes_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint for Azure Kubernetes Service (AKS)"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.host
  sensitive   = true
}

output "region" {
  description = "Azure Kubernetes Service (AKS) Cluster region"
  value       = var.region
}

output "cluster_security_group_id" {
  description = "Network Security Group ID for the Azure Kubernetes Service (AKS) Cluster"
  value       = azurerm_kubernetes_cluster.main.network_profile.0.network_security_group_id
}
*/