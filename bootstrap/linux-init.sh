#!/bin/bash

sudo apt update

sudo apt install -y \
  curl \
  zsh \
  jq \
  peco \
  neovim \
  unzip \

curl https://mise.run | MISE_VERSION=v2025.3.10 sh
