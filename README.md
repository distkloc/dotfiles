# My dotfiles

## Installation

## OSX

### Prerequisites

* Git

### Run the setup script

```sh
git clone https://github.com/distkloc/dotfiles.git ~/dotfiles
cd ~/dotfiles
bootstrap/mac.sh
```

### Install homebrew formulae and mac apps

```sh
brew bundle --global
```

### Select node.js version with nodebrew

```sh
nodebrew install-binary stable
nodebrew use stable
```


## Windows (with PowerShell)

### Prerequisites

* Chocolatey
* Git

### Change PowerShell execution policy

```posh
Set-ExecutionPolicy RemoteSigned
```

### Run the setup script

```posh
git clone https://github.com/distkloc/dotfiles.git $HOME\dotfiles
cd ~/dotfiles
./bootstrap/windows.ps1
```

### Install chocolatey packages

```posh
cinst chocolatey/packages.config
```

### Select node.js version with nodist

```posh
nodist + stable
nodist stable
```
