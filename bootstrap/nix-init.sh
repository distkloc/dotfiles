#!/bin/bash

# git config
git config --global include.path "${DOT_PATH%/}/.gitconfig"


# tmux plugin manager (tpm)
tpm_path=~/.tmux/plugins/tpm
if [ ! -d "$tpm_path" ]; then
    git clone https://github.com/tmux-plugins/tpm "$tpm_path"
fi


# AI coding agents (native install)
# PATH is managed in .zshenv; keep ~/.local/bin on PATH so installers don't edit shell profiles
export PATH="$HOME/.local/bin:$PATH"

# Claude Code
if ! command -v claude &> /dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

# Codex
if ! command -v codex &> /dev/null; then
    curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh
fi
