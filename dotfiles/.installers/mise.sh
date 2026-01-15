#!/bin/bash
set -euo pipefail

# Install kind
if ! command -v mise > /dev/null; then
    sudo apt update -y && sudo apt install -y curl
    sudo install -dm 755 /etc/apt/keyrings
    curl -fsSL https://mise.jdx.dev/gpg-key.pub | sudo gpg --dearmor -o /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
    sudo apt update -y
    sudo apt install -y mise
else
    echo "mise already installed"
fi
