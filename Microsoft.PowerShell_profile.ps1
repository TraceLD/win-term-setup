Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History

Import-Module PSFzf

# Override PSReadLine's history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                -PSReadlineChordReverseHistory 'Ctrl+r'

# Override default tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Register-ArgumentCompleter -Native -CommandName nuke -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    nuke :complete "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

Import-Module -Name Terminal-Icons

# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

Set-Alias winfetch pwshfetch-test-1
Set-Alias python3 python
Set-Alias java8 "C:\Program Files\Eclipse Adoptium\jdk-8.0.332.9-hotspot\bin\java.exe"
Set-Alias java18 "C:\Program Files\Eclipse Adoptium\jdk-18.0.1.10-hotspot\bin\java.exe"

$BAT_THEME = "TwoDark"

Invoke-Expression (&starship init powershell)
