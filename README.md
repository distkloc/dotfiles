# My dotfiles

## Installation

## OSX

### Prerequisites

* Git

### Run the setup script

```sh
git clone https://github.com/distkloc/dotfiles.git ~/dotfiles
cd ~/dotfiles
zsh bootstrap/mac.zsh
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

* NuGet (by Package Management)
* Git

### Change PowerShell execution policy

```posh
Set-ExecutionPolicy RemoteSigned
```

### Install Chocolatey package provider

```posh
Start-Process powershell -Verb runAs "Install-PackageProvider Chocolatey"
```

#### See installed PackageProviders

```posh
Get-PackageSource
```

### Run the setup script

```posh
git clone https://github.com/distkloc/dotfiles.git $HOME\dotfiles
cd ~/dotfiles
Start-Process powershell -Verb runAs $Home\dotfiles\bootstrap\windows.ps1
```

### Install chocolatey packages

```posh
choco install chocolatey/packages.config
```

### Select node.js version with nodist

```posh
nodist + latest
nodist latest
```
