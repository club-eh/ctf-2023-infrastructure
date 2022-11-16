## Variable definitions that are shared between environments

variable "secrets_dir" {
  type        = string
  description = "Path to secrets directory."
  nullable    = false
}

variable "domain" {
  type        = string
  description = "Root domain name to create env-specific subdomains on."
  nullable    = false
}
