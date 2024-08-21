#!/bin/bash
set -euo pipefail

readonly SYSTEM_PACKAGES=(jq git yq zsh ripgrep direnv keychain)
readonly PYTHON_DEPS=(build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev curl git \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev)

# Install packages and stuff needed later on.
sudo apt-get update
sudo apt-get install --upgrade --yes ${SYSTEM_PACKAGES[*]}
sudo apt-get install --upgrade --yes ${PYTHON_DEPS[*]}
