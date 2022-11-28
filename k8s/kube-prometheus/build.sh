#!/usr/bin/env bash

# originally based on https://github.com/prometheus-operator/kube-prometheus/blob/35f69e8b03bdfed476769e9e0992bd750a393387/build.sh

set -euxo pipefail

cd "$(dirname "$(realpath "$0")")"

TARGET_DIR="../resources/vendor/kube-prometheus"

# wipe target directory structure
rm -r "$TARGET_DIR"

# generate JSON manifests
jsonnet -J vendor -c -m "$TARGET_DIR" main.jsonnet | xargs -I{} mv {} {}.yaml
