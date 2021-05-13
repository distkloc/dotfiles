#!/bin/bash

sudo apt update

sudo apt install -y \
  curl \
  zsh \
  jq \
  peco \
  neovim \
  dirmngr gpg # asdf-nodejs depends on

chsh -s $(which zsh) # must enter password


# poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
$HOME/.local/bin/poetry config virtualenvs.in-project true
