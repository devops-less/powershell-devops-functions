function Invoke-SecretLint {
    Write-Log "secret detection..."
    Test-Tool 'npm' -Assert
    Invoke-ShellCommand "npm install -g secretlint @secretlint/secretlint-rule-preset-recommend" 'secretlint install'
    Invoke-ShellCommand "secretlint **/*" 'secretlint'
}
