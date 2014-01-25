# Created by newuser for 5.0.2

# homebrew
export PATH=/usr/local/bin:$PATH

source ~/dotfiles/zsh/.antigenrc

setopt nonomatch

# rbenv
eval "$(rbenv init -)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH


setopt AUTO_CD
cdpath=(.. ~ ~/src)


# vim
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
