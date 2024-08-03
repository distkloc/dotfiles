# for powerline font
export LANG=ja_JP.UTF-8

# homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi
