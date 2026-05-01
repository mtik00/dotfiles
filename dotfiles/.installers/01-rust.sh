#!/bin/bash
set -euo pipefail

if [[ ! -d "${HOME}/.cargo/env" ]]; then
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -q -y --no-modify-path
    source "${HOME}/.cargo/env"
else
    echo "rust already installed at: ${HOME}/.cargo"
fi
