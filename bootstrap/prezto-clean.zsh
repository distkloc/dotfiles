#!/bin/zsh

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  if [ -L "${ZDOTDIR:-$HOME}/.${rcfile:t}" ] ; then
    unlink "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  fi
done

rm -rf ~/.zprezto
