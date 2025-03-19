#!/bin/bash
set -euo pipefail

## Install lazygit
if ! command -v lazygit > /dev/null; then
    readonly LAZYGIT_LATEST_URL=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases | grep browser_download_url | grep Linux_x86_64 | head -1 | cut -d '"' -f 4)
    curl -L -o /tmp/lazygit.tgz "${LAZYGIT_LATEST_URL}"
    tar xzf /tmp/lazygit.tgz -C "$HOME/bin"
    rm /tmp/lazygit.tgz
else
    echo "lazygit already installed"
fi
