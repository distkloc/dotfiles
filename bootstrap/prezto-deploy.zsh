#!/bin/zsh

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  if [ -L "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]; then
    echo "File exists: ${ZDOTDIR:-$HOME}/.${rcfile:t}"
    continue
  fi

  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
