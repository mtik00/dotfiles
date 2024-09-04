#!/bin/bash
set -euo pipefail

export PYTHON_VERSION="3.11.9"
export HOME_BIN="${HOME}/bin"
export PYENV_ROOT="${HOME}/.local/share/pyenv"
export PATH="${HOME}/bin:${HOME}/.local/share/pyenv/bin:$PATH"

# Make sure this is here and its in the path
mkdir -p "${HOME}/bin"

# Some light git setup
if ! [[ -f ~/.gitconfig ]]; then
    git config --global credential.helper cache
fi