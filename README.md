# My dotfiles

The whole setup is declared for [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html).

## Installation

The repo lives in the ghq layout: `~/src/github.com/distkloc/dotfiles`.

### macOS / Linux

```sh
curl -fsSL https://raw.githubusercontent.com/distkloc/dotfiles/main/bootstrap/install.sh | bash
```

This installs Homebrew (macOS) or curl and git (Linux), installs mise, clones the repo, and runs `mise bootstrap --yes`.

### Windows (PowerShell)

```posh
irm https://raw.githubusercontent.com/distkloc/dotfiles/main/bootstrap/install.ps1 | iex
```

## Usage

```sh
mise bootstrap --dry-run   # preview changes
mise bootstrap --yes       # apply
mise dotfiles status       # show drift of the dotfile links
```
