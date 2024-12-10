function Invoke-CSpell {
    param(
        [string]$Folder,
        [string]$Pattern = "**/*"
    )

    Write-Log "spell checking..."
    Test-Tool 'npx' -Assert
    Invoke-ShellCommand "npx -y cspell --no-progress $Pattern" 'cspell' -WorkingDirectory $Folder
}
