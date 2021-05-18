# terraform

if [[ -s "/usr/bin/terraform" ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/bin/terraform terraform
fi
