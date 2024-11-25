
if ($Env:OS -eq "Windows_NT") {
    $Env:Path += ";$HOME\AppData\Local\Programs\oh-my-posh\bin"
}
else {
    $Env:PATH += ":$HOME/bin"
}

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

# fish風のオートサジェスト機能を有効に
Set-PSReadLineOption -PredictionSource History -PredictionViewStyle InlineView

Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
