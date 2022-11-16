output "pip_ingress" {
  value = azurerm_public_ip.ingress.ip_address
}

output "pip_challenges" {
  value = azurerm_public_ip.challenges.ip_address
}


output "kube_config" {
  value = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive = true
}
