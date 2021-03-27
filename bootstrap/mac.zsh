#!/bin/sh

# homebrew
if ! type "brew" > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# homebrew-bundle
brew tap Homebrew/bundle

# git config
git config --global include.path "~/dotfiles/.gitconfig"


# dein.vim
bundle_path=~/dotfiles/.vim/bundle/repos/github.com/Shougo/dein.vim
if [ ! -d $bundle_path ]; then
    mkdir -p $bundle_path
    git clone https://github.com/Shougo/dein.vim ${bundle_path}
fi

# symlink
DOT_FILES=( .vim .vimrc .gvimrc .zshrc .zshenv .zpreztorc .tmux.conf .Brewfile )

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


# prezto
if [ ! -d ~/.zprezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

# anyenv
anyenv install --init
anyenv install pyenv
anyenv install nodenv
touch $(nodenv root)/default-packages

exec $SHELL -l

