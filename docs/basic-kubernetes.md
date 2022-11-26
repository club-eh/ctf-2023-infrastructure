# Getting Started

## Preface

You're going to want a Unix environment: WSL, MacOS, and Linux should all work fine, but I can't promise you'll have a good time with Windows.
I'm assuming you already have `git clone`ed the repo at `https://github.com/club-eh/ctf-2023-infra-2-wip` into a local directory named `infra`.

Requirements for generally doing anything are [Installing Tools](#installing-tools), [First-time setup](#first-time-setup), and then [Per-cluster setup](#per-cluster-setup).


## Installing tools

### Kubectl

Install instructions available here: [https://kubernetes.io/docs/tasks/tools/#kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

Once installed, you should be able to run `kubectl version --client` and get version info for `kubectl` (ignore any "depreciation" warnings).

### Azure CLI

Install instructions available here: [https://learn.microsoft.com/en-us/cli/azure/install-azure-cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

Once installed, you should be able to run `az version` and get version info as a JSON object.

### ytt (from Carvel)

Install instructions available here: [https://carvel.dev/ytt/docs/v0.44.0/install/](https://carvel.dev/ytt/docs/v0.44.0/install/)

Once installed, you should be able to run `ytt --version` and get a simple version string.


## First-time setup

### Azure authentication

You'll need to login to Azure CLI by running `az login --tenant a0260531-0423-4d90-9d73-4390f5cc7215`  
This works by going through a browser sign-in process, after which you should see a JSON object describing your user account.


## Per-cluster setup

NOTE: this needs to be run through every time the cluster is recreated / etc.

### kubectl credentials

Run `az aks get-credentials -g Capstone -n <name of cluster>` to get the credentials for the cluster.

If the cluster is running, `kubectl version` should now return a server version (in addition to client version, etc.)


## Kubernetes Dashboard

1. Setup the API server proxy: `kubectl proxy` (should say "Starting to serve on 127.0.0.1:8001")
2. Access the dashboard WebUI at http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
3. To generate a token (required to login): `kubectl create token -n kubernetes-dashboard --duration 30m`
4. Copy-paste the output into the WebUI field and login.
