#!/bin/bash
set -euo pipefail

## Install starship
if ! command -v starship > /dev/null; then
    export FORCE=1
    curl -sS https://starship.rs/install.sh | sh
else
    echo "starship already installed"
fi