New-Item $PROFILE -ItemType 'file' -Value '#' -Force 
Copy-Item -Path Microsoft.PowerShell_profile.ps1 -Destination $PROFILE -Force
. $PROFILE