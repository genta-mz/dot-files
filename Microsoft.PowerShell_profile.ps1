oh-my-posh init pwsh --config ~/jandedobbeleer.omp.json | Invoke-Expression

Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
    $list = Get-Content -Path (Get-PSReadlineOption).HistorySavePath | Select-Object -Unique
    [Array]::Reverse($list)

    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()

    if (gcm perldoc -ea SilentlyContinue) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($(echo $list | peco))
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($(echo $list | Out-GridView -PassThru))
    }
}
