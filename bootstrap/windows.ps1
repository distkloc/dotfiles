
#Check current role
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $arguments

    break
}


# Create vim directories and install neobundle
$vimDir = "Env:HOME\dotfiles\.vim"
if(-not (Test-Path $vimDir))
{
    @("bundle", "backup", "swap")
        | % { New-Item -ItemType Directory -Path "$vimDir\$_" }

    git clone git://github.com/Shougo/neobundle.vim "$vimDir\bundle\neobundle.vim"
}


# Symlink
function Invoke-Mklink($name)
{
    $link = "$Env:HOME\$name"

    if((Test-Path $link))
    {
        Write-Output "$link already exists."
    }
    else
    {
        $dotfiles = "$Env:HOME\dotfiles"

        if(Test-Path $link -pathType container)
        {
            cmd /c mklink /d $link "$dotfiles\$name"
        }
        else
        {
            cmd /c mklink $link "$dotfiles\$name"
        }
    }
}

@(".vimrc", ".gvimrc", ".vim")
    | % { Invoke-Mklink $_ }

if((Test-Path $profile))
{
    Write-Output "$profile already exists."
}
else
{
    cmd /c mklink $profile "$Env:HOME\dotfiles\.profile.ps1"
}


# nodist
if (-not (Get-Command "nodist" -ErrorAction SilentlyContinue))
{
    cinst nodist -Pre
}
