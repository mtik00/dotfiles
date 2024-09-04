#!/bin/bash
set -euo pipefail

## Install fzf
if ! command -v fzf > /dev/null; then
    readonly FZF_LATEST_URL=$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4)
    curl -L -o /tmp/fzf.tgz "${FZF_LATEST_URL}"
    tar xzf /tmp/fzf.tgz -C "$HOME/bin"
    rm /tmp/fzf.tgz
else
    echo "fzf already installed"
fi