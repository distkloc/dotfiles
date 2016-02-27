
#Check current role
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $arguments

    break
}


# crlf
git config --global core.autocrlf true


# Create vim directories and install dein.vim
$vimDir = "$Env:HOME\dotfiles\.vim"


if(-not (Test-Path $vimDir))
{
    @("bundle", "backup", "swap", "undo", "viminfo") |
        % { New-Item -Path "$vimDir\$_" -ItemType Directory }

    git clone https://github.com/Shougo/dein.vim "$vimDir\bundle\repos\github.com\Shougo\dein.vim"
}


# Symlink
function Invoke-Mklink($base, $dest)
{
    $link = "$Env:HOME\$dest"

    if((Test-Path $link))
    {
        Write-Output "$link already exists."
    }
    else
    {
        $realPath = "$Env:HOME\dotfiles\.$base"

        if(Test-Path $realPath -pathType container)
        {
            cmd /c mklink /d $link $realPath
        }
        else
        {
            cmd /c mklink $link $realPath
        }
    }
}

$dothash = @{ 
    vimrc=".vimrc"
    gvimrc=".gvimrc"
    vim="vimfiles"
}

$dothash.Keys | % { Invoke-Mklink $_ $dothash[$_] }


# nodist
if (-not (Get-Command "nodist" -ErrorAction SilentlyContinue))
{
    cinst nodist -Pre
}

