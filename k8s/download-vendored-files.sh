#!/bin/bash

# download vendored K8s manifests

set -e

#VERSION_OLM="0.22.0"
VERSION_INGRESS_NGINX="1.5.1"
VERSION_KUBE_DASHBOARD="2.7.0"
VERSION_ECK="2.5.0"
#VERSION_PROM_OPERATOR="0.61.1"


dl() { wget -nv --show-progress "$@"; }

cd "$(dirname "$(realpath "$0")")"

mkdir -p resources/vendor

#dl -O resources/vendor/olm-crds.yaml "https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v${VERSION_OLM}/crds.yaml"
#dl -O resources/vendor/olm.yaml "https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v${VERSION_OLM}/olm.yaml"

dl -O resources/vendor/ingress-nginx.yaml "https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v${VERSION_INGRESS_NGINX}/deploy/static/provider/cloud/deploy.yaml"

dl -O resources/vendor/kube-dashboard.yaml "https://raw.githubusercontent.com/kubernetes/dashboard/v${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml"

dl -O resources/vendor/eck-crds.yaml "https://download.elastic.co/downloads/eck/${VERSION_ECK}/crds.yaml"
dl -O resources/vendor/eck-operator.yaml "https://download.elastic.co/downloads/eck/${VERSION_ECK}/operator.yaml"

#dl -O resources/vendor/prometheus-operator.yaml "https://github.com/prometheus-operator/prometheus-operator/releases/download/v${VERSION_PROM_OPERATOR}/bundle.yaml"
