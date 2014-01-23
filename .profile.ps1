### Powershell initialization script ###
# Call from ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 as follows:
# 	. "~/dotfiles/.profile.ps1"
# The head '.' is necessary.
########################################

# Load posh-git example profile
. "C:\tools\poshgit\dahlbyk-posh-git-f9361ca\profile.example.ps1"

# path for git
$env:path += ";" + (Get-Item "Env:ProgramFiles").Value + "\Git\bin"

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

# display current timestamp on prompt
# function prompt {
  # (Get-Date).ToString("yyyy/MM/dd hh:mm:ss:fff") + " " + $(get-location) + "> "
# }

