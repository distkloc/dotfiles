#!/bin/bash

# symlink
for file in .??*
do
  ( [[ "$file" = ".git"* ]] || \
  [ "$file" = ".DS_Store" ] || \
  [[ "$file" = *".ps1" ]] ) && continue

  ln -fnsv ${DOT_PATH%/}/$file ~/$file
done

# neovim
mkdir -p ${DOT_PATH%/}/.config/nvim
ln -fnsv ${DOT_PATH%/}/.vimrc ~/.config/nvim/init.vim

# vim directory
mkdir -p {~/.vim/backup,~/.vim/swap,~/.vim/undo,~/.vim/viminfo}
