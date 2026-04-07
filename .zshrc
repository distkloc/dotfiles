# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.0.2

setopt correct
setopt nonomatch
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt share_history
setopt incappendhistory


# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit

case ${OSTYPE} in
    darwin*)
        source ~/.mac.zshrc
        ;;
    linux*)
        source ~/.linux.zshrc
        ;;
esac

if [[ -f ~/.local.zshrc ]]; then
  source ~/.local.zshrc
fi

# sheldon
if command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"
fi

# mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
fi

# kubectl
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# git wt
if git wt -h >/dev/null 2>&1; then
  eval "$(git wt --init zsh)"
fi

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

# vim
alias vim=nvim
alias vi=nvim


bindkey -d # reset bindkey
bindkey -e # use emacs style

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
bindkey '^\\g' peco-src

function peco-vscode-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="code ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-vscode-src
bindkey '^\\o' peco-vscode-src

function peco-git-wt () {
  local worktrees=$(git wt 2>/dev/null | tail -n +2)
  if [ -z "$worktrees" ]; then
    zle clear-screen
    return
  fi

  local selected=$(echo "$worktrees" | peco | awk '{print $(NF-1)}')
  if [ -n "$selected" ]; then
    BUFFER="git wt ${selected}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-git-wt
bindkey '^\\w' peco-git-wt

function tmux-claude-session () {
  local parts=(${(s:/:)PWD})
  local session_name="claude-${parts[-2]}--${parts[-1]}"
  if (( ${#session_name} > 36 )); then
    local hash=$(print -n -- "$session_name" | shasum | awk '{print $1}')
    local max_prefix=$((36 - 1 - 8))
    session_name="${session_name:0:${max_prefix}}-${hash:0:8}"
  fi
  BUFFER="tmux new-session -A -s ${session_name}"
  zle accept-line

}
zle -N tmux-claude-session
bindkey '^\\a' tmux-claude-session

function peco-tmux-session () {
  local selected=$(tmux ls -F '#{session_name}' 2>/dev/null | peco --query "$LBUFFER")
  if [ -n "$selected" ]; then
    BUFFER="tmux attach -t ${selected}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-tmux-session
bindkey '^\\t' peco-tmux-session

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
bindkey '^\\s' peco-ssh


function peco-kubectx () {
    local selected_ctx=$(kubectl config get-contexts | awk 'NR>1{print $2}' | peco --query "$LBUFFER")
    if [ -n "$selected_ctx" ]; then
        BUFFER="kubectl config use-context ${selected_ctx}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-kubectx
bindkey '^\\c' peco-kubectx

function peco-gcloud-project () {
    local selected_project=$(gcloud projects list --format="value(projectId)" | peco --query "$LBUFFER")
    if [ -n "$selected_project" ]; then
        BUFFER="gcloud config set project ${selected_project}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-gcloud-project
bindkey '^\\p' peco-gcloud-project

# op
if [[ -f "$HOME/.env.1password" ]]; then
  alias opr='op run --env-file="$HOME/.env.1password" -- '

  # peco + saml2aws
  function peco-saml2aws () {
    local selected_profile=$(awk -F "[][]" '/\[.*\]/ { print $2 }' ~/.saml2aws | sort | peco --query "$LBUFFER")
    if [ -n "$selected_profile" ]; then
        BUFFER="opr saml2aws login -a ${selected_profile} --disable-keychain"
        zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-saml2aws
  bindkey '^\\2' peco-saml2aws
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
