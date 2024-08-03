
# zsh
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

# color
export TERM=xterm-256color

# pip
export PATH=$PATH:$HOME/.local/bin

# poetry
export PATH="$HOME/.local/bin/poetry:$PATH"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
