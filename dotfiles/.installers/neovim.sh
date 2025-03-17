#!/bin/bash
set -euo pipefail

## Install difftastic
if ! command -v nvim > /dev/null; then
    readonly NEOVIM_LATEST_URL=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -v "nightly" | grep browser_download_url | grep nvim-linux-x86_64.tar.gz\" | cut -d '"' -f 4)
    curl -L -o /tmp/nvim.tgz "${NEOVIM_LATEST_URL}"
    tar xzf /tmp/nvim.tgz -C "$HOME/bin"
    ln -fs "$HOME/bin/nvim-linux-x86_64/bin/nvim" "$HOME/bin/nvim"
    rm /tmp/nvim.tgz
else
    echo "nvim already installed"
fi

if [ ! -d $HOME/.config/nvim ]; then
    git clone git@github.com:mtik00/nvim-config.git $HOME/.config/nvim
fi
