
# homebrew
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# go
set -x GOPATH $HOME
set -x PATH $PATH $GOPATH/bin

# color
set -x TERM xterm-256color

# fisher initialization
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# bobthefish
set -g theme_display_date no


# vim
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi=vim
alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim --remote-tab-silent "$*"'

