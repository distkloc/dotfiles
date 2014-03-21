#!/bin/sh

DOT_FILES=( .vim .vimrc .gvimrc .zshrc .zshenv )

for file in ${DOT_FILES[@]}
do
  if [ -e ~/$file ]; then
    echo "$file already exists"
  else
    ln -s ~/dotfiles/$file ~/$file
    echo "Symlink was created: $file"
  fi
done

