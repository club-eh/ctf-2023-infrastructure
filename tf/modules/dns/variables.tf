variable "secrets_dir" {
  type        = string
  description = "Path to the secrets directory."
  nullable    = false
}

variable "domain" {
  type        = string
  description = "Root domain name to create a subdomain on."
  nullable    = false
}

variable "subdomain" {
  type        = string
  description = "Base subdomain to create."
  nullable    = false
}

variable "ip_ingress" {
  type        = string
  description = "IP address for the cluster ingress (CTFd and admin/monitoring services)."
  nullable    = false
}

variable "ip_challenges" {
  type        = string
  description = "IP address for dynamic challenges."
  nullable    = false
}
