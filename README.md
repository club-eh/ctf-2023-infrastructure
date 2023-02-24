# club.eh 2023 CTF - Infrastructure 2.0

This repository contains our attempt at creating cloud infrastructure to host [a CTF competition](https://github.com/club-eh/ctf-2023-challenges).  
It is unfinished: many aspects were never implemented or completed.

It is a bit of a mess - many mistakes were made, and we do not recommend anyone follow **exactly** in our footsteps.  
Nevertheless, we've published it with the hope that some parts can be useful or interesting to others.


## Layout

| Directory | Description |
| --- | --- |
| `docs/` | Documentation (not much of it) |
| `k8s/` | Our Kubernetes YAML manifests, using [ytt](https://carvel.dev/ytt/) for templating / patching |
| `tf/` | Our (unfinished) Terraform config (not used in production) |


## Unfinished Notes

This was our first time using Kubernetes, and we became more and more time-constrained as the competition date drew closer.  
As such, many aspects of this repo are incomplete, unfinished, untested, or even went unused in our final deployment.

### Terraform

We originally planned to use Terraform, but after spending roughly a month fighting various issues with Azure, we decided that it was no longer worth the additional time investment.

### Log Aggregation

We originally planned to look into different logging stacks, such as ELK and EFK, to consolidate logs from throughout our infrastructure into a single place.  
Unfortunately, we did not have enough time to even explore our options, let alone securely implement and configure a proper solution.

### Separate Environments

Our plan was to have 2 or 3 separate environments:

- Production (in Azure, accessible to the world)
- Staging (in a private homelab, accessible to all contributors)
- Local/testing (able to be spun up on anyone's local machine)

Unfortunately, Kubernetes is not entirely independent of its underlying environment.  
Our infrastructure became heavily reliant on AKS-specific resources, particularly storage and network resources, which made deployment in non-cloud environments infeasible (without an excessive amount of environment-specific configuration).

It's likely possible to partially (or even entirely) factor out the environment-specific config to isolate it.  
However, given our limited time and resources, we figured it would not be worth the additional time and effort, and opted instead to just test our infra in Azure.

Under normal circumstances, this would've inflated our costs considerably; thankfully for us, our corporate sponsor covered all our costs in Azure.
