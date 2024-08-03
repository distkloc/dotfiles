#!/bin/bash

# neovim
if [ -L ~/.config/nvim/init.vim ] ; then
  unlink ~/.config/nvim/init.vim
fi


for file in .?*
do
  ( [[ "$file" = ".git"* ]] || \
  [ "$file" = ".DS_Store" ] || \
  [[ "$file" = *".ps1" ]] ) && continue

  if [ -L ~/$file ] ; then
    unlink ~/$file
  fi
done

# asdf
if [ -d ~/.asdf ] ; then
  rm -rf ~/.asdf
fi
