#!/bin/sh

# homebrew
if ! type "brew" > /dev/null; then
    ruby -e '$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)'
fi

# nodebrew
if ! type "nodebrew" > /dev/null; then
    curl -L git.io/nodebrew | perl - setup
fi

# go
go_path=$HOME/go
if [ ! -d $go_path ]; then
    mkdir ${go_path}
fi

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

