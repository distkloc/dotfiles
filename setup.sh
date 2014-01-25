#!/bin/sh

DOT_FILES=( .vim .vimrc .gvimrc .zshrc )

for file in ${DOT_FILES[@]}
do
  if [ -a $HOME/$file ]; then
    echo "$file already exists"
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
    echo "Symlink was created: $file"
  fi
done
