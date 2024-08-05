#!/bin/bash

# symlink
for file in .??*
do
  ( [[ "$file" = ".git"* ]] || \
  [ "$file" = ".DS_Store" ] || \
  [[ "$file" = *".ps1" ]] ) && continue

  ln -fnsv ${DOT_PATH%/}/$file ~/$file
done

mkdir -p ~/.config

# Symlink directories from dotconfig to ~/.config
for dir in ${DOT_PATH%/}/dotconfig/*/
do
  dir=${dir%/}  # Remove trailing slash
  base_dir=$(basename "$dir")
  ln -fnsv "$dir" "$HOME/.config/$base_dir"
done

# neovim
mkdir -p ~/.config/nvim
ln -fnsv ${DOT_PATH%/}/.vimrc ~/.config/nvim/init.vim

# vim directory
mkdir -p {~/.vim/backup,~/.vim/swap,~/.vim/undo,~/.vim/viminfo}
