#!/bin/bash
set -euo pipefail

ZSH_LOC=$(command -v zsh)

# Configure zsh to be the default shell
if ! grep "${ZSH_LOC}" /etc/shells > /dev/null; then
    echo "${ZSH_LOC}" | sudo tee -a /etc/shells > /dev/null
fi

if ! [[ "${SHELL}" == *"zsh" ]]; then
    echo
    echo "Setting zsh to be your default shell."
    echo "Enter your user password when prompted:"
    chsh -s "${ZSH_LOC}"
fi
