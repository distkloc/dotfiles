#!/bin/bash

# git config
git config --global include.path "${DOT_PATH%/}/.gitconfig"


# tmux plugin manager (tpm)
tpm_path=~/.tmux/plugins/tpm
if [ ! -d "$tpm_path" ]; then
    git clone https://github.com/tmux-plugins/tpm "$tpm_path"
fi
