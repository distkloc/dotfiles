
#Check current role
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $arguments

    break
}


# Create vim directories and install neobundle
$vimDir = "$Env:HOME\dotfiles\.vim"


if(-not (Test-Path $vimDir))
{
    @("bundle", "backup", "swap") |
        % { New-Item -Path "$vimDir\$_" -ItemType Directory }

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
        $realPath = "$Env:HOME\dotfiles\$name"

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

@(".vimrc", ".gvimrc", ".vim") |
    % { Invoke-Mklink $_ }

# nodist
if (-not (Get-Command "nodist" -ErrorAction SilentlyContinue))
{
    cinst nodist -Pre
}