#!/bin/sh

# neobundle.vim
bundle_path=~/dotfiles/.vim/bundle
if [ ! -d $bundle_path ]; then
    mkdir -p $bundle_path
    git clone git://github.com/Shougo/neobundle.vim ${bundle_path}/neobundle.vim
fi

# symlink
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

# vim directory
mkdir ~/.vim/backup
mkdir ~/.vim/swap

