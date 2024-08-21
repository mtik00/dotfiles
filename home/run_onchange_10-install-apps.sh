#!/bin/bash
set -euo pipefail

readonly PYTHON_VERSION="3.11.9"
readonly HOME_BIN="${HOME}/bin"

# Make sure this is here and its in the path
mkdir -p "${HOME_BIN}"
export PATH="${HOME_BIN}:${PATH}"

# Some light git setup
if ! [[ -f ~/.gitconfig ]]; then
    git config --global credential.helper cache
fi

# Install pyenv
if ! command -v pyenv; then
    rm -rf ${HOME}/.pyenv
    curl https://pyenv.run | bash
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if ! echo $(pyenv global) | grep $PYTHON_VERSION > /dev/null; then
    pyenv update
    pyenv install --skip-existing ${PYTHON_VERSION}
    pyenv global ${PYTHON_VERSION}
else
    echo "Python ${PYTHON_VERSION} already installed."
fi

# Make sure poetry is installed in global config
if ! command -v poetry; then
    $(pyenv which python) -m pip install --upgrade pip poetry
fi

# Install desk (https://github.com/jamesob/desk)
if ! [[ -f "${HOME_BIN}/desk" ]]; then
    curl https://raw.githubusercontent.com/jamesob/desk/master/desk > "${HOME_BIN}/desk"
    chmod +x "${HOME_BIN}/desk"
else
    echo "desk already installed"
fi

# Install starship
if ! command -v starship > /dev/null; then
    export FORCE=1
    curl -sS https://starship.rs/install.sh | sh
else
    echo "starship already installed"
fi

# Install fzf
if ! command -v fzf > /dev/null; then
    readonly FZF_LATEST_URL=$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4)
    curl -L -o /tmp/fzf.tgz "${FZF_LATEST_URL}"
    tar xzf /tmp/fzf.tgz -C "$HOME/bin"
    rm /tmp/fzf.tgz
else
    echo "fzf already installed"
fi
