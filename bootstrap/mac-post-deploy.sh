#!/bin/bash

mise use -g node@latest

eval "$(/opt/homebrew/bin/brew shellenv)"

# homebrew-bundle
brew tap Homebrew/bundle
brew bundle --file ${DOT_PATH%/}/.Brewfile # Use .Brewfile

mise use -g usage
mise use -g kubectl@latest
mise use -g kubectl-convert@latest

exec -l $(which zsh)
