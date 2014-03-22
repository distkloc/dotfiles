# My very own dotfiles

## Installation

### Clone repository

```
git clone git@github.com:distkloc/dotfiles.git ~/dotfiles
```

## OSX

### Run the setup script

```
cd ~/dotfiles
bootstrap/mac.sh
```

### Install homebrew formulae and mac apps

```
brew bundle Brewfile/Brewfile
```

### Select node.js version with nodebrew

```
nodebrew install-binary stable
nodebrew use stable
```


## Windows (with PowerShell)

### Change PowerShell execution policy

```
Set-ExecutionPolicy RemoteSigned
```

### Install Chocolatey

Because this installation uses git, you need to install it somewhere.

Use chocolatey here.

[Installation · chocolatey/chocolatey Wiki](https://github.com/chocolatey/chocolatey/wiki/Installation)

### Install chocolatey packages

```
cd ~/dotfiles
cinst chocolatey/packages.config
```

### Run the script

```
./bootstrap/windows.ps1
```

### Select node.js version with nodist

```
nodist + stable
nodist stable
```
