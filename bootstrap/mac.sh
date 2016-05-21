#!/bin/sh

# homebrew
if ! type "brew" > /dev/null; then
    ruby -e '$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)'
fi

# homebrew-bundle
brew tap Homebrew/bundle

# nodebrew
if ! type "nodebrew" > /dev/null; then
    curl -L git.io/nodebrew | perl - setup
fi

# git config
git config --global include.path "~/dotfiles/.gitconfig"

# dein.vim
bundle_path=~/dotfiles/.vim/bundle/repos/github.com/Shougo/dein.vim
if [ ! -d $bundle_path ]; then
    mkdir -p $bundle_path
    git clone https://github.com/Shougo/dein.vim ${bundle_path}
fi

# symlink
DOT_FILES=( .vim .vimrc .gvimrc .zshrc .zshenv .tmux.conf .Brewfile )

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
mkdir ~/.vim/undo
mkdir ~/.vim/viminfo


# submodule initialization
git submodule update --init

