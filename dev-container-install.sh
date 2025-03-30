#!/bin/bash

HISTORY_DIR="/workspace/.devcontainer/.history"
mkdir -p $HISTORY_DIR

echo "export HISTFILE=$HISTORY_DIR/zsh" >> ~/.local.zshrc

make all
