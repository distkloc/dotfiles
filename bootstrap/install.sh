#!/bin/bash
# Seed a new macOS/Linux machine: install the prerequisites mise cannot install itself,
# clone this repo to the ghq path, then hand over to `mise bootstrap`.
set -euo pipefail

# Use the checkout this script lives in (e.g. a devcontainer's dotfiles clone);
# otherwise (curl | bash) clone to the ghq path.
DOT_PATH="${HOME}/src/github.com/distkloc/dotfiles"
if [ -f "${BASH_SOURCE[0]:-}" ]; then
  script_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  [ -f "${script_root}/mise.toml" ] && DOT_PATH="$script_root"
fi

case "$(uname)" in
  Darwin)
    if ! command -v brew &> /dev/null; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
    command -v mise &> /dev/null || brew install mise
    ;;
  Linux)
    SUDO=""
    [ "$(id -u)" -ne 0 ] && SUDO="sudo"
    $SUDO apt-get update
    $SUDO apt-get install -y curl git
    export PATH="${HOME}/.local/bin:${PATH}"
    command -v mise &> /dev/null || curl https://mise.run | sh
    ;;
esac

if [ ! -d "$DOT_PATH" ]; then
  git clone https://github.com/distkloc/dotfiles.git "$DOT_PATH"
fi

cd "$DOT_PATH"
mise trust
mise bootstrap --yes
