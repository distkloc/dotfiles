#!/bin/sh

# homebrew
if ! command -v brew &> /dev/null
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# homebrew-bundle
brew tap Homebrew/bundle
brew bundle --file ${DOT_PATH%/}/.Brewfile # Use .Brewfile
