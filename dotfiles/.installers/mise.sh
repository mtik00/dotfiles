#!/bin/bash
set -euo pipefail

# Install kind
if ! command -v mise > /dev/null; then
    curl https://mise.run | MISE_INSTALL_PATH=~/.local/bin/mise sh
else
    echo "mise already installed"
fi
