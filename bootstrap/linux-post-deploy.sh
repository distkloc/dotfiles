#!/bin/bash

MISE_DIR="${HOME}/.local/bin"

$MISE_DIR/mise use -g usage
$MISE_DIR/mise use -g kubectl@latest
$MISE_DIR/mise use -g kubectl-convert@latest

chsh -s $(which zsh)
