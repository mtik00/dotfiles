#!/bin/bash
set -euo pipefail

# Rust/Cargo needs to be installed first.
if [[ ! -f "${HOME}/.cargo/env" ]]; then
    echo "ERROR: Rust/Cargo not installed"
    exit 1
fi

source "${HOME}/.cargo/env"

if ! command -v fd > /dev/null; then
    cargo install fd-find
else
    echo "fd-find already installed at: $(command -v fd)"
fi
