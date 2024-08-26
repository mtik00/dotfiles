#!/usr/bin/env bash

DO_INSTALL=$(grep -P '^[[:space:]]+install_op' ${HOME}/.config/chezmoi/chezmoi.toml | cut -d '=' -f2 | awk '{print $1}')
[[ "${DO_INSTALL}" == "false" ]] && exit

readonly HOME_BIN="${HOME}/bin"

if ! [ -f "${HOME_BIN}/op" ]; then

    mkdir -p "${HOME_BIN}"
    sudo apt-get install unzip

    wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.30.0/op_linux_amd64_v2.30.0.zip" -O op.zip
    unzip -d op op.zip
    sudo mv op/op ${HOME_BIN}/
    rm -r op.zip op
    sudo groupadd -f onepassword-cli
    sudo chgrp onepassword-cli ${HOME_BIN}/op
    sudo chmod g+s ${HOME_BIN}/op

    # This file can't be a template, so we need to scrape the config file for the
    # email address.
    EMAIL=$(grep -P '^[[:space:]]+email' ${HOME}/.config/chezmoi/chezmoi.toml | cut -d '"' -f2)
    ${HOME_BIN}/op account add --address my.1password.com --email "${EMAIL}"
fi

# TODO: What about other password managers: keepass/bitwarden/keeper/etc?
# https://www.chezmoi.io/user-guide/password-managers/
