# Created by newuser for 5.0.2

source ~/dotfiles/zsh/.antigenrc

setopt nonomatch

# rbenv
eval "$(rbenv init -)"


setopt AUTO_CD
cdpath=(.. ~ ~/src)

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


# peco
function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-select-history() {
  typeset tac
  if which tac > /dev/null; then
    tac=tac
  else
    tac='tail -r'
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle -R -c
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-pkill() {
  for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="peco-pkill"


# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# boot2docker shellinit
if [ "`boot2docker status`" = "running" ]; then
    $(boot2docker shellinit)
fi

