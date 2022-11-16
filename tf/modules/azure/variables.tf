variable "az_resource_group" {
  type = string
  description = "Name of the pre-existing Azure resource group"
  nullable = false
}

variable "az_region" {
  type = string
  description = "Name of the Azure region to create resources in"
  nullable = false
}

variable "cluster_node_count" {
  type = number
  description = "Number of worker nodes to create"
  default = 1
}

variable "cluster_node_size" {
  type = string
  description = "VM size for the worker nodes"
  nullable = false
}

variable "cluster_k8s_version" {
  type = string
  description = "Version of Kubernetes to use across the cluster"
  nullable = false
}
