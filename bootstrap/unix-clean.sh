#!/bin/sh

# neovim
if [ -L ~/.config/nvim/init.vim ] ; then
  unlink ~/.config/nvim/init.vim
fi


for file in .?*
do
  ( [[ "$file" = ".git"* ]] || \
  [ "$file" = ".DS_Store" ] || \
  [[ "$file" = *".ps1" ]] ) && continue

  if [ -L ~/$file ] ; then
    unlink ~/$file
  fi
done

# prezto
if [ -x "$(command -v zsh)" ] && \
  [ -d ~/.zprezto ]; then

  zsh -c ${DOT_PATH%/}/bootstrap/prezto-clean.zsh
fi

# asdf
if [ -d ~/.asdf ] ; then
  rm -rf ~/.asdf
fi
