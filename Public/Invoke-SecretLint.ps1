function Invoke-SecretLint {
    param(
        [string]$Path
    )
    Test-Tool 'npm' -Assert
    Trace-Expression -name 'secretlint install' {
        Invoke-NodeGlobalInstall 'secretlint'
        Invoke-NodeGlobalInstall '@secretlint/secretlint-rule-preset-recommend'
    }

    Trace-Expression -Name 'secret detection' {   
        Invoke-ShellCommand "secretlint **/*" 'secretlint' -Print -WorkingDirectory $Path
    }
}
