#!/bin/bash
set -euo pipefail

PATH="~/bin:${PATH}"

# Set up files in the home directory
if [[ -d ~/.local/share/chezmoi/.git ]]; then
    chezmoi update
else
    pushd "${HOME}" && sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/mtik00/chezmoi-wsl.git && popd
fi
