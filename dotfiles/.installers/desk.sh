#!/bin/bash
set -euo pipefail

## Install desk (https://github.com/jamesob/desk)
if ! [[ -L "${HOME_BIN}/desk" ]]; then
    mkdir -p "${HOME}/.local/share"
    git clone https://github.com/jamesob/desk "${HOME}/.local/share/desk"
    ln -s ${HOME}/.local/share/desk/desk ${HOME}/bin/desk
else
    echo "desk already installed"
fi