# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"

# zsh
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

# color
export TERM=xterm-256color

export EDITOR=nvim

export PATH=$PATH:$HOME/.local/bin

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
