# Seed a new Windows machine: install mise and git, clone this repo to the ghq path,
# then hand over to `mise bootstrap`.
$ErrorActionPreference = "Stop"

$dotPath = "$HOME\src\github.com\distkloc\dotfiles"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    winget install --id Git.Git -e --source winget
}
if (-not (Get-Command mise -ErrorAction SilentlyContinue)) {
    winget install --id jdx.mise -e --source winget
}
# Pick up PATH changes from the installers
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path", "User")

if (-not (Test-Path $dotPath)) {
    git clone https://github.com/distkloc/dotfiles.git $dotPath
}

Set-Location $dotPath
mise trust
mise bootstrap --yes
