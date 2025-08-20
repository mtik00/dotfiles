#!/bin/bash
set -euo pipefail

# Install yq
if ! command -v yq > /dev/null; then
    readonly YQ_LATEST_URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64"
    curl -L -o ${HOME}/bin/yq "${YQ_LATEST_URL}"
    chmod +x ${HOME}/bin/yq
else
    echo "yq already installed"
fi
