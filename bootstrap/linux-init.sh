#!/bin/bash

apt update

apt install -y \
  curl \
  zsh \
  jq \
  peco \
  neovim \
  unzip \

curl https://mise.run | MISE_VERSION=v2025.3.10 sh

# sheldon
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
