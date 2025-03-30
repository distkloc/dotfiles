#!/bin/bash

echo "export HISTFILE=/workspace/.devcontainer/.zsh_history" >> ~/.local.zshrc

make all
