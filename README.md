# chromium-operator

chromium-operator allows to deploy Chromium browsers inside kubernetes cluster and
access them using various protocols (CDP, VNC and so on).

## Getting started

Install chromium operator using commands below:

```bash
skaffold run
```

Create browser using custom resource:

```bash
kubectl apply -f - <<EOF
apiVersion: chromium.chromium-operator.com/v1alpha1
kind: Chromium
metadata:
  name: chromium-sample
spec:
  proxy: ""
  vncEnabled: true
EOF
```

Access browser using port-forward:

```bash
kubectl port-forward svc/chromium-sample 9222
open http://localhost:9222/vnc
```

## Development

```bash
kind create cluster --name chromium-operator
skaffold dev
```
