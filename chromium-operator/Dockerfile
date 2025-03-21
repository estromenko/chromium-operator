FROM quay.io/operator-framework/helm-operator:v1.39.2

ENV HOME=/opt/helm

WORKDIR ${HOME}

COPY chromium-operator/watches.yaml ${HOME}/watches.yaml

COPY charts/chromium ${HOME}/chromium
