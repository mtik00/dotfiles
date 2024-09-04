#!/bin/bash
set -euo pipefail

PYTHON_VERSION=${PYTHON_VERSION:-3.11.9}
PYENV_ROOT="${HOME}/.local/share/pyenv"
PATH="$PYENV_ROOT/bin:$PATH"

# Install pyenv
if ! command -v pyenv; then
    mkdir -p "${HOME}/.local/share"
    rm -rf "${HOME}/.local/share/pyenv"

    git clone https://github.com/pyenv/pyenv.git "${PYENV_ROOT}"
    cd "${HOME}/.local/share/pyenv" && src/configure && make -C src
    git clone https://github.com/pyenv/pyenv-update.git "${PYENV_ROOT}/plugins/pyenv-update"
else
    echo "pyenv already installed"
fi

eval "$(pyenv init -)"

if ! echo $(pyenv global) | grep ${PYTHON_VERSION} > /dev/null; then
    pyenv update
    pyenv install --skip-existing ${PYTHON_VERSION}
    pyenv global ${PYTHON_VERSION}
else
    echo "Python ${PYTHON_VERSION} already installed."
fi