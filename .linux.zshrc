# terraform
if [[ -s "$HOME/.asdf/shims/terraform" ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C $HOME/.asdf/shims/terraform terraform
fi

# for powerline font
export LANG=C.UTF-8
