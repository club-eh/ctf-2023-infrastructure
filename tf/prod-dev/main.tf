## Root module

terraform {
  required_version = ">= 1.1.0"
}


# Azure resources
module "azure" {
  source = "../modules/azure"

  az_region = "westus3"  # using a different region for now to avoid hitting PIP limit
  az_resource_group = "Capstone"

  cluster_k8s_version = "1.24.6"  # TODO: update to 1.25.x when it's available

  cluster_node_size = "standard_b4ms"  # cheap option that's available in westus3
  cluster_node_count = 1
}

# DNS records
module "dns" {
  source = "../modules/dns"

  # Shared variables
  secrets_dir = var.secrets_dir
  domain      = var.domain

  # Subdomain for this environment
  subdomain = "ctf-2023"

  # Azure IPs TODO: use azure module outputs
  ip_ingress    = module.azure.pip_ingress
  ip_challenges = module.azure.pip_challenges
}
