#!/bin/bash
set -euo pipefail

# Install keeper commander CLI
if ! command -v keeper > /dev/null; then
    $(pyenv which python) -m pip install --upgrade keepercommander
else
    echo "keeper already installed"
fi
