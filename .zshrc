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


# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ -s "$ZINIT_HOME" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
fi

# zinit plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions


# asdf
if [[ -s "$HOME/.asdf/asdf.sh" ]]; then
  . $HOME/.asdf/asdf.sh

  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
fi

# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit



# vim
alias vi=vim
alias gvim='mvim --remote-tab-silent "$*"'


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


case ${OSTYPE} in
    darwin*)
        source ~/.mac.zshrc
        ;;
    linux*)
        source ~/.linux.zshrc
        ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
