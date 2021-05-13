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
mkdir -p ~/.config/nvim
ln -fnsv ${DOT_PATH%/}/.vimrc ~/.config/nvim/init.vim

# vim directory
mkdir -p {~/.vim/backup,~/.vim/swap,~/.vim/undo,~/.vim/viminfo}

# prezto
if [ -x "$(command -v zsh)" ] && [ -d ~/.zprezto ]; then

  # https://stackoverflow.com/questions/33665820/how-to-execute-zsh-shell-commands-in-bash-script
  zsh -c ${DOT_PATH%/}/bootstrap/prezto-deploy.zsh
fi
