
#Check current role
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $arguments

    break
}


# Symlink
function Invoke-Mklink($name, $isDir=$false)
{
    $link = "$Env:HOME\$name"
    if((Test-Path "$link"))
    {
        Write-Output "$link already exists."
    }
    else
    {
        $dotfiles = "$Env:HOME\dotfiles"

        if($isDir)
        {
            cmd /c mklink /d "$link" "$dotfiles\$fileName"
        }
        else
        {
            cmd /c mklink "$link" "$dotfiles\$fileName"
        }
    }
}

@(".vimrc", ".gvimrc")
    | % { Invoke-Mklink $_ }

# Create vim directories and install neobundle
$vimDir = "Env:HOME\dotfiles\.vim"
if(-not (Test-Path $vimDir))
{
    @("bundle", "backup", "swap")
        | % { New-Item -ItemType Directory -Path "$vimDir\$_" }

    git clone git://github.com/Shougo/neobundle.vim "$vimDir\bundle\neobundle.vim"
}

Invoke-Mklink ".vim" $true  

if((Test-Path $profile))
{
    Write-Output "$profile already exists."
}
else
{
    cmd /c mklink $profile "$Env:HOME\.profile.ps1"
}

