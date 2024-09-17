#!/bin/bash
set -euo pipefail

## Install zellij
if ! command -v zellij > /dev/null; then
    readonly ZELLIG_LATEST_URL=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | grep browser_download_url | grep x86_64-unknown-linux | grep .tar.gz | cut -d '"' -f 4)
    curl -L -o /tmp/zellij.tgz "${ZELLIG_LATEST_URL}"
    tar xzf /tmp/zellij.tgz -C "$HOME/bin"
    rm /tmp/zellij.tgz
else
    echo "zellij already installed"
fi