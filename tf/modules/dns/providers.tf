terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.25"
    }
  }
}


# Cloudflare provider configuration
provider "cloudflare" {
  # Pull API token from secrets file
  api_token = file("${var.secrets_dir}/api_token_cloudflare")
}
