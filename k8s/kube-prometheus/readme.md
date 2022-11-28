This directory contains the source code for the [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) resources.  
Based on their documentation: [https://github.com/prometheus-operator/kube-prometheus/blob/main/docs/customizing.md](https://github.com/prometheus-operator/kube-prometheus/blob/main/docs/customizing.md)

Any changes to main.jsonnet or updates to vendor dependencies should be applied by running the `build.sh` script to generate the manifest files under the proper directory.
