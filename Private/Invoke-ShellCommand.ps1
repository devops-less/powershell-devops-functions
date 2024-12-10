function Invoke-ShellCommand {
    param(
        [Parameter(Position = 0, Mandatory)][string]$Command,
        [Parameter(Position = 1)][string]$Name = '',
        [string]$WorkingDirectory,
        [switch]$Result
    )

    If ($WorkingDirectory) {
        Write-Log "Directory: $WorkingDirectory" -Level Debug
        Push-Location $WorkingDirectory
    }

    Write-Log "$Command" -Level Debug
    $Res = iex $Command
    Assert-Condition ($LASTEXITCODE -eq 0) "$Name" -ExitCode $LASTEXITCODE
    If ($WorkingDirectory) {
        Pop-Location
    }
    If ($Result.IsPresent) {
        $Value = $Res | Where-Object { $_ } | ForEach-Object { $_.ToString() } | Out-String
        RETURN $Value
    }
}
