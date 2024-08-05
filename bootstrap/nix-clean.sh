#!/bin/bash

# neovim
if [ -L ~/.config/nvim/init.vim ] ; then
  unlink ~/.config/nvim/init.vim
  rm -rf ~/.config/nvim
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

for dir in ${DOT_PATH%/}/dotconfig/*/
do
  dir=${dir%/}  # Remove trailing slash
  base_dir=$(basename "$dir")

  if [ -L "$HOME/.config/$base_dir" ] ; then
    unlink "$HOME/.config/$base_dir"
  fi
done

# asdf
if [ -d ~/.asdf ] ; then
  rm -rf ~/.asdf
fi
