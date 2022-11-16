#!/bin/bash

cd "$(dirname "$(realpath "$0")")"


# import CTFd secrets
kubectl create secret generic -n "ctfd" "ctfd-secrets" --from-file="./ctfd/"

# import Elasticsearch users
for user in "fluentbit"; do
	kubectl create secret generic -n "monitoring" "elasticsearch-user-${user}" --type='kubernetes.io/basic-auth' --from-env-file=elasticsearch/fluentbit
done
