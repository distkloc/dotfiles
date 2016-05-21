### Powershell initialization script ###
# Call from ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 as follows:
# 	. "~/dotfiles/.profile.ps1"
# The head '.' is necessary. This file needs to be loaded before posh-git profile file.
########################################


# path for git/MigGW
$Env:Path += ";$HOME\AppData\Local\Programs\Git\cmd;$HOME\AppData\Local\Programs\Git\usr\bin"

# GOPATH
$Env:GOPATH = "$HOME"
$Env:Path += ";$Env:GOPATH\bin"

# saved history count 
$MaximumHistoryCount = 7000

# Hustiry configs
$HistoryFile = Join-Path (Split-Path $Profile -Parent) history.xml
# Save history at the end
Register-EngineEvent PowerShell.Exiting -SupportEvent -Action {
 Get-History -count $MaximumHistoryCount | Export-Clixml $HistoryFile
}
# Load history at start-up
if (Test-Path $HistoryFile) {
 Import-Clixml $HistoryFile | Add-History
}

#docker-machine
if ((Invoke-Expression "docker-machine status default") -eq "Running") {
  docker-machine env default | Invoke-Expression
}

# Alias
Set-Alias gskip Invoke-GitUpdateIndexSkipWorktree
Set-Alias gnoskip Invoke-GitUpdateIndexNoSkipWorktree
Set-Alias gignored Invoke-GitLsFiles
Set-Alias gnffcmerge Invoke-GitNoFastForwordNoMerge
Set-Alias pg Invoke-PecoSrc

$vimpath = "$HOME\programs\vim74-kaoriya-win64"
New-Alias vim "$vimpath\vim.exe" -Force
New-Alias gvim "$vimpath\gvim.exe" -Force


function Invoke-GitUpdateIndexSkipWorktree
{
    git update-index --skip-worktree $args
}

function Invoke-GitUpdateIndexNoSkipWorktree
{
    git update-index --no-skip-worktree $args
}

function Invoke-GitLsFiles
{
    git ls-files -v | grep "^[Sa-z]"
}

function Invoke-GitNoFastForwordNoMerge ($branch)
{
	git merge --no-ff --no-commit $branch
}

function Invoke-PecoSrc
{
    $selectedDir = $(ghq list -p | peco)

    if($selectedDir -ne $null) {
        cd $selectedDir
    }
}
