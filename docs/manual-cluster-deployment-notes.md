# Manual Cluster Deployment Notes

## Main Deployment

(most commands require the working directory to be `k8s/`)

#### 1. Create new AKS cluster via web portal

#### 2. Obtain privileges on cluster RG

[redacted-1] manually assigns us access to the AKS-managed resource group.

#### 3. Retrieve cluster credentials

```
az aks get-credentials --name capstone-production-cluster --resource-group Capstone
```

#### 4. Create public IP resources

Manually create public IP address resources called `ingress-pip` and `challenges-pip` in the AKS-managed RG.

#### 5. Update recorded public IPs

`k8s/values-azure.yaml` needs to be updated with the new IPs.  
The DNS records in Cloudflare also need to be manually updated to match.

#### 6. Deploy initial Kubernetes resources (namespaces, etc.)

```
ytt -f resources/ -f filter-initial.yaml -f values-azure.yaml | kubectl apply --server-side -f-
```

#### 7. Deploy the Kubernetes dashboard

```
ytt -f resources/vendor/kube-dashboard.yaml -f resources/values-schema.yaml -f values-azure.yaml | kubectl apply -f-
kubectl apply -f dashboard-admin.yaml
```

#### 8. Import secrets

Import cluster-only secrets: `bash secrets/import-secrets.sh`  
Import TLS certificates: `bash tls/install-secret.sh` (only accessible on [redacted-2]'s machine)

#### 9. Deploy ingress-nginx

```
ytt -f resources/vendor/ingress-nginx.yaml -f resources/vendor/overlays/ingress-nginx-overlay.yaml -f resources/vendor/ingress-nginx-config-map.yaml -f resources/values-schema.yaml -f values-azure.yaml | kubectl apply -f-
```


## Kubernetes Dashboard Access

- Run `kubectl proxy` to create a tunnel to the cluster API server
- Run `kubectl create token --duration 30m -n kubernetes-dashboard admin-user` to get an auth token (valid for 30 minutes)


## Container Image Registry

`ytt -f resources/image-registry/ -f resources/values-schema.yaml -f values-azure.yaml | kubectl apply -f-`


## CTFd Image

- `cd images/ctfd`
- `./build.sh`
- `skopeo copy --dest-creds admin:$(<../../secrets/registry/admin-password) containers-storage:localhost/ctf2023_ctfd docker://registry.ctf-2023.clubeh.ca:443/infra/ctfd:latest`


## CTFd Deploy

- `ytt -f resources/ctfd/ -f resources/values-schema.yaml -f values-azure.yaml | kubectl apply -f-`


## OAuth2 Deploy

- `./secrets/import-oauth2.sh`
- `ytt -f resources/auth/ -f resources/values-schema.yaml -f values-azure.yaml | kubectl apply -f-`


## Metrics Deploy

- `ytt -f resources/vendor/kube-prometheus/ -f resources/monitoring/metrics/ -f resources/values-schema.yaml -f values-azure.yaml | kubectl apply -f-`


## Minio

After installing minio-client, run this to setup an alias for accessing the server:
`mcli alias set ctf2023-minio https://minio.ctf-2023.clubeh.ca admin $(<./secrets/ctfd/minio-root-password)`

Create the ctfd user:
`mcli admin user add ctf2023-minio ctfd $(<./secrets/ctfd/minio-ctfd-secret-key)`

Create the bucket for CTFd files:
`mcli mb ctf2023-minio/ctfd`

