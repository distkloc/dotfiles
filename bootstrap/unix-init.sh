#!/bin/bash

# git config
git config --global include.path "${DOT_PATH%/}/.gitconfig"


# dein.vim
bundle_path=${DOT_PATH%/}/.vim/bundle/repos/github.com/Shougo/dein.vim
if [ ! -d $bundle_path ]; then
    mkdir -p $bundle_path
    git clone https://github.com/Shougo/dein.vim ${bundle_path}
fi


# zinit
if [ -x "$(command -v zsh)" ]; then
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

  if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  fi
fi

# asdf
if [ ! -d ~/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  cd -
fi
