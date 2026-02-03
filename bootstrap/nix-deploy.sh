#!/bin/bash

# symlink
for file in .??*
do
  case "$file" in
    .git*|.DS_Store|*.ps1|.*vimrc)
      continue
      ;;
  esac

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

# vim directory
mkdir -p {~/.vim/backup,~/.vim/swap,~/.vim/undo,~/.vim/viminfo}
