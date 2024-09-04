#!/bin/bash
set -euo pipefail

## Make sure poetry is installed in global config
if ! command -v poetry >/dev/null; then
    $(pyenv which python) -m pip install --upgrade pip poetry
else
    echo "poetry already installed"
fi