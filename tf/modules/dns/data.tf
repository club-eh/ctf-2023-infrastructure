# Cloudflare zone for the base domain (clubeh.ca)
data "cloudflare_zone" "base" {
  name = var.domain
}
