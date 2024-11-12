#!/bin/bash
set -euo pipefail

if ! [[ -L "/usr/local/bin/aws" ]]; then
    mkdir -p /tmp/awscli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscli/awscliv2.zip"
    unzip /tmp/awscli/awscliv2.zip -d /tmp/awscli
    sudo /tmp/awscli/aws/install
    rm -rf /tmp/awscli
else
    echo "awscli already installed"
fi
