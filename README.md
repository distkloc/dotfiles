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

### macOS defaults

`mise.macos.toml` declares macOS preferences in `[bootstrap.macos.*]`. mise writes them but does not restart the apps that read them, so some changes only show up after a restart ([Restart affected apps](https://mise.jdx.dev/bootstrap/macos-defaults.html#app-restarts)):

```sh
killall Dock Finder SystemUIServer
```

Keyboard shortcuts (`com.apple.symbolichotkeys`) are read at login. Log out and back in, or reload them in place:

```sh
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
```
