#!/bin/bash
set -euo pipefail

# Install kind
if ! command -v kind > /dev/null; then
    readonly KIND_LATEST_URL=$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | grep browser_download_url | grep linux-amd64 | grep -v sha256sum | cut -d '"' -f 4)
    curl -L -o ${HOME}/bin/kind "${KIND_LATEST_URL}"
    chmod +x ${HOME}/bin/kind
else
    echo "kind already installed"
fi

# Install kubectl
if ! command -v kubectl > /dev/null; then
    curl -L -o  ${HOME}/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ${HOME}/bin/kubectl
else
    echo "kubectl already installed"
fi

# Install helm
if ! command -v helm > /dev/null; then
    export HELM_INSTALL_DIR=${HOME}/bin
    export USE_SUDO=false
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
    echo "helm already installed"
fi

# Install k3d
if ! command -v k3d > /dev/null; then
    export K3D_INSTALL_DIR=${HOME}/bin
    export USE_SUDO=false
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
else
    echo "k3d already installed"
fi