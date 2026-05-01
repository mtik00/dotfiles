#!/bin/bash
set -euo pipefail

## Install treesitter
if ! command -v tree-sitter > /dev/null; then
    readonly TREE_SITTER_LATEST_URL=$(curl -s https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest | grep browser_download_url | grep linux-x86.gz | cut -d '"' -f 4)
    curl -L -o /tmp/tree-sitter.gz "${TREE_SITTER_LATEST_URL}"
    gunzip /tmp/tree-sitter.gz -c > "$HOME/bin/tree-sitter"
    chmod +x "$HOME/bin/tree-sitter"
    rm /tmp/tree-sitter.tgz
else
    echo "tree-sitter already installed"
fi
