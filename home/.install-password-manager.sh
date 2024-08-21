#!/usr/bin/env bash

DO_INSTALL=$(grep -P '^[[:space:]]+install_op' ${HOME}/.config/chezmoi/chezmoi.toml | cut -d '=' -f2 | awk '{print $1}')
[[ "${DO_INSTALL}" == "false" ]] && exit

if ! [ -f "${HOME}/bin/op" ]; then

    mkdir -p "${HOME}/bin"
    sudo apt-get install unzip

    wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.30.0/op_linux_amd64_v2.30.0.zip" -O op.zip
    unzip -d op op.zip
    sudo mv op/op ${HOME}/bin/
    rm -r op.zip op
    sudo groupadd -f onepassword-cli
    sudo chgrp onepassword-cli ${HOME}/bin/op
    sudo chmod g+s ${HOME}/bin/op

    # This file can't be a template, so we need to scrape the config file for the
    # email address.
    EMAIL=$(grep -P '^[[:space:]]+email' ${HOME}/.config/chezmoi/chezmoi.toml | cut -d '"' -f2)
    ${HOME}/bin/op account add --address my.1password.com --email "${EMAIL}"
fi
