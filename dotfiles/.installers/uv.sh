#!/bin/bash
set -euo pipefail

## Install starship
if ! command -v uv > /dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "uv already installed; updating"
    uv self update
fi
