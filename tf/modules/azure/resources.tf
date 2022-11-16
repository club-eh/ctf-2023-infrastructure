resource "azurerm_kubernetes_cluster" "main" {
  location = var.az_region
  resource_group_name = data.azurerm_resource_group.main.name

  name = "tf-cluster-testing"
  dns_prefix = "tf-cluster-testing"

  kubernetes_version = var.cluster_k8s_version

  default_node_pool {
    name = "default"
    node_count = var.cluster_node_count
    vm_size = var.cluster_node_size
    enable_auto_scaling = false
    orchestrator_version = var.cluster_k8s_version

    linux_os_config {
      sysctl_config {
        # for Elasticsearch
        vm_max_map_count = 262144
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  # TODO: private cluster
  #private_cluster_enabled = true
}


resource "azurerm_public_ip" "ingress" {
  location = var.az_region
  resource_group_name = var.az_resource_group

  name = "cluster-ingress-pip"
  sku = "Standard"
  allocation_method = "Static"
}

resource "azurerm_public_ip" "challenges" {
  location = var.az_region
  resource_group_name = var.az_resource_group

  name = "cluster-challenges-pip"
  sku = "Standard"
  allocation_method = "Static"
}
