# Created by newuser for 5.0.2

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
alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim --remote-tab-silent "$*"'


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


function peco-ssh () {
  local selected_host=$(awk '
  tolower($1)=="host" {
    for (i=2; i<=NF; i++) {
      if ($i !~ "[*?]") {
        print $i
      }
    }
  }
  ' ~/.ssh/config | sort | peco --query "$LBUFFER")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ssh
bindkey '^\' peco-ssh

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

