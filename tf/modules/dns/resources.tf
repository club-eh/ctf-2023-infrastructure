# DNS records for ingress (ctf-2023.clubeh.ca)
resource "cloudflare_record" "ingress" {
  zone_id = data.cloudflare_zone.base.id
  type    = "A"
  ttl     = 300 # 5 minutes
  name    = var.subdomain
  value   = var.ip_ingress
}
resource "cloudflare_record" "ingress_wildcard" {
  zone_id = data.cloudflare_zone.base.id
  type    = "A"
  ttl     = 300 # 5 minutes
  name    = "*.${var.subdomain}"
  value   = var.ip_ingress
}

# DNS records for dynamic challenges (chals.ctf-2023.clubeh.ca)
resource "cloudflare_record" "challenges" {
  zone_id = data.cloudflare_zone.base.id
  type    = "A"
  ttl     = 300 # 5 minutes
  name    = "chals.${var.subdomain}"
  value   = var.ip_challenges
}
