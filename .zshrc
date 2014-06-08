# Created by newuser for 5.0.2

source ~/dotfiles/zsh/.antigenrc

setopt nonomatch

# rbenv
eval "$(rbenv init -)"


setopt AUTO_CD
cdpath=(.. ~ ~/dev)

# z
_Z_CMD=j
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
   _z --add "$(pwd -P)"
}

# vim
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi=vim


# git
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

