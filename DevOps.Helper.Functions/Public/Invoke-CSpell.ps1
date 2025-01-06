function Invoke-CSpell {
    param(
        [string]$Path,
        [string]$Pattern = "**/*"
    )
    Test-Tool 'npx' -Assert
    Trace-Expression -Name 'spell checking' {
        Invoke-ShellCommand "npx -y cspell --no-progress $Pattern" 'cspell' -WorkingDirectory $Path
    }
}
