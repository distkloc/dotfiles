# Created by newuser for 5.0.2

source ~/dotfiles/zsh/.antigenrc

setopt nonomatch

# rbenv
eval "$(rbenv init -)"


setopt AUTO_CD
cdpath=(.. ~ ~/src)


# vim
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi=vim

