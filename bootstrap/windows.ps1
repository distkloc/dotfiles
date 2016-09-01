# git config
git config --global core.autocrlf true
git config --global include.path "~/dotfiles/.gitconfig"

# Create vim directories and install dein.vim
$vimDir = "$HOME\dotfiles\.vim"


@("backup", "swap", "undo", "viminfo") |
    % { 
        $itemDir = "$vimDir\$_"
        if(Test-Path $itemDir)
        {
          Write-Output "$itemDir already exists."
        }
        else
        {
          New-Item -Path "$itemDir" -ItemType Directory 
        }
      }

$deinCacheDir = "$vimDir\bundle" 
if(-not (Test-Path $deinCacheDir))
{
    New-Item -Path $deinCacheDir -ItemType Directory
    git clone https://github.com/Shougo/dein.vim "$deinCacheDir\repos\github.com\Shougo\dein.vim"
}

# Symlink
function Invoke-Mklink($base, $dest)
{
    $link = "$HOME\$dest"

    if((Test-Path $link))
    {
        Write-Output "$link already exists."
    }
    else
    {
        $realPath = "$HOME\dotfiles\.$base"

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
    Install-Package -Name nodist
}

