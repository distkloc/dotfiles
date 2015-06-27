# My dotfiles

## Installation

## OSX

### Prerequisites

* Git
* Homebrew

### Run the setup script

```
git clone git@github.com:distkloc/dotfiles.git ~/dotfiles
cd ~/dotfiles
bootstrap/mac.sh
```

### Install homebrew formulae and mac apps

```
cd Brewfile
brew bundle Brewfile
```

### Select node.js version with nodebrew

```
nodebrew install-binary stable
nodebrew use stable
```


## Windows (with PowerShell)

### Prerequisites

* Chocolatey
* Git

### Change PowerShell execution policy

```
Set-ExecutionPolicy RemoteSigned
```

### Run the setup script

```
git clone git@github.com:distkloc/dotfiles.git $HOME\dotfiles
cd ~/dotfiles
./bootstrap/windows.ps1
```

### Install chocolatey packages

```
cinst chocolatey/packages.config
```

### Select node.js version with nodist

```
nodist + stable
nodist stable
```
