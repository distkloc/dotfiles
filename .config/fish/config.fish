
# homebrew
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# go
set -x GOPATH $HOME
set -x PATH $PATH $GOPATH/bin

# color
set -x TERM xterm-256color

# bobthefish
set -g theme_display_date no
