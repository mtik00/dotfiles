#!/bin/bash
set -euo pipefail

## Install difftastic
if ! command -v difft > /dev/null; then
    readonly DIFFT_LATEST_URL=$(curl -s https://api.github.com/repos/Wilfred/difftastic/releases/latest | grep browser_download_url | grep x86_64-unknown-linux | cut -d '"' -f 4)
    curl -L -o /tmp/difft.tgz "${DIFFT_LATEST_URL}"
    tar xzf /tmp/difft.tgz -C "$HOME/bin"
    rm /tmp/difft.tgz
else
    echo "difft already installed"
fi