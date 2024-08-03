#!/bin/bash

# homebrew-bundle
brew tap Homebrew/bundle
brew bundle --file ${DOT_PATH%/}/.Brewfile # Use .Brewfile
