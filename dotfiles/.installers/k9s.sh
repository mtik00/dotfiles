#!/bin/bash
set -euo pipefail

# Install k9s
if ! command -v k9s > /dev/null; then
    readonly K9S_LATEST_URL=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep browser_download_url | grep -i k9s_linux_amd64.tar.gz | grep -v json | cut -d '"' -f 4)
    curl -s -L -o /tmp/k9s.tgz "${K9S_LATEST_URL}"
    tar -zxvf /tmp/k9s.tgz -C ~/bin k9s
    rm -f /tmp/k9s.tgz
else
    echo "k9s already installed"
fi
