#!/bin/bash

# symlink
for file in .??*
do
  case "$file" in
    .git*|.DS_Store|*.ps1|.*vimrc|.claude)
      continue
      ;;
  esac

  ln -fnsv ${DOT_PATH%/}/$file ~/$file
done

# Symlink dot* directories (dot prefix -> . prefix)
for src_prefix in ${DOT_PATH%/}/dot*/; do
  [[ -e "$src_prefix" ]] || continue
  src_prefix=${src_prefix%/}
  base_name=$(basename "$src_prefix")
  dest_prefix="${base_name/dot/.}"  # dot -> .

  mkdir -p "$HOME/$dest_prefix"

  # Symlink items under dot* directory
  for item in "$src_prefix"/*; do
    [[ -e "$item" ]] || continue
    item_name=$(basename "$item")
    ln -fnsv "$item" "$HOME/$dest_prefix/$item_name"
  done
done

# vim directory
mkdir -p {~/.vim/backup,~/.vim/swap,~/.vim/undo,~/.vim/viminfo}
