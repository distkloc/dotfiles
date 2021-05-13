#!/bin/bash

# git config
git config --global include.path "${DOT_PATH%/}/.gitconfig"


# dein.vim
bundle_path=${DOT_PATH%/}/.vim/bundle/repos/github.com/Shougo/dein.vim
if [ ! -d $bundle_path ]; then
    mkdir -p $bundle_path
    git clone https://github.com/Shougo/dein.vim ${bundle_path}
fi

# prezto
if [ -x "$(command -v zsh)" ] && [ ! -d ~/.zprezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

if [ -x "$(command -v poetry)" ] && [ -d ~/.zprezto ]; then
  # Zsh (prezto)
  poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry
fi

# asdf
if [ ! -d ~/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  cd -
fi
