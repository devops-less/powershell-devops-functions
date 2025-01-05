function Invoke-MarkdownLint {
    param(
        [string]$Path,
        [string]$Pattern = "**/*.md",
        [string]$Ignore = "**/node_modules/**"
    )

    Test-Tool 'npx' -Assert
    Trace-Expression -Name 'markdown lint' {   
        Invoke-ShellCommand "npx -y markdownlint-cli $Pattern --ignore $Ignore" 'markdownlint' -WorkingDirectory $Path
    }
}
