function Invoke-MarkdownLint {
    param(
        [string]$Pattern = "**/*.md",
        [string]$Ignore = "**/node_modules/**"
    )

    Write-Log "markdown lint..."
    Test-Tool 'npx' -Assert
    Invoke-ShellCommand "npx -y markdownlint-cli $Pattern --ignore $Ignore" 'markdownlint'
}
