#!/bin/bash

cd "$(dirname "$(realpath "$0")")"


# import CTFd secrets
kubectl create secret generic -n "ctfd" "ctfd-secrets" --from-file="./ctfd/"

# import registry htpasswd
kubectl create secret generic -n "image-registry" "htpasswd" --from-file="htpasswd=./registry/htpasswd"

# import cluster's registry credentials
for namespace in ctfd challenges; do
	kubectl create secret docker-registry -n ${namespace} registry-creds --docker-server="registry.ctf-2023.clubeh.ca" --docker-username=admin --docker-password=$(<registry/admin-password)
done

# import Elasticsearch users
for user in "fluentbit"; do
	kubectl create secret generic -n "monitoring" "elasticsearch-user-${user}" --type='kubernetes.io/basic-auth' --from-env-file=elasticsearch/fluentbit
done
