This directory is intentionally left empty in the public repository.

We used [`lego`](https://go-acme.github.io/lego/) to semi-automate the generation of TLS certificates (signed by [Let's Encrypt](https://letsencrypt.org/)).  
We used the `DNS-01` challenge for two reasons: we wanted to use wildcard certificates, and spinning up an HTTP server is much tedious and error-prone vs. providing a Cloudflare API token to manipulate DNS records.

We decided to generate certificates ourselves and upload them to the cluster (as opposed to automatically obtaining certificates with [`cert-manager`](https://cert-manager.io/)) to avoid accidentally hitting [LE's rate limits](https://letsencrypt.org/docs/rate-limits/) during development and testing.
