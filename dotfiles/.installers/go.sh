#!/bin/bash
set -euo pipefail

# Install go
if ! command -v go > /dev/null; then
    readonly LOCAL_DIR="${HOME}/.local"
    readonly LATEST_VERSION=$(curl --silent 'https://go.dev/VERSION?m=text' | head -1)
    readonly LATEST_URL="https://go.dev/dl/${LATEST_VERSION}.linux-amd64.tar.gz"
    curl -L -o /tmp/go.tgz "${LATEST_URL}"

    rm -rf "${LOCAL_DIR}/go"
    mkdir -p "${LOCAL_DIR}"

    tar -xzf /tmp/go.tgz -C "${LOCAL_DIR}"
    rm -f /tmp/go.tgz
else
    echo "go already installed at: $(command -v go)"
fi
