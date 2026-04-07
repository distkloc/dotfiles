#!/bin/bash

mise use -g node@latest

eval "$(/opt/homebrew/bin/brew shellenv)"

# homebrew bundle
brew bundle --file ${DOT_PATH%/}/.Brewfile

mise use -g kubectl@latest
mise use -g kubectl-convert@latest

exec -l $(which zsh)
