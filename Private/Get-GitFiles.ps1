function Get-GitFiles {
    param(
        [string]$Path
    )

    Test-Tool 'git' -Assert
    $Res = Invoke-ShellCommand "git ls-files" 'git' -Result -WorkingDirectory $Path
    $Files = ($Res -replace "`n", "") -split "`r" | ForEach-Object { $_.Trim() } | Where-Object { $_ }
    RETURN $Files
}