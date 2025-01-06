function Invoke-ShellCommand {
    param(
        [Parameter(Position = 0, Mandatory)][string]$Command,
        [Parameter(Position = 1)][string]$Name = '',
        [string]$WorkingDirectory,
        [int[]]$ValidCodes = @(0),
        [switch]$Result,
        [switch]$NoEcho
    )

    If ($WorkingDirectory) {
        Write-Log "Directory: $WorkingDirectory" -Level Debug
        Push-Location $WorkingDirectory
    }

    Write-Log "$Command" -Level Debug
    Try {
        $Res = iex "$Command 2>&1"
        $ResCode = $LASTEXITCODE
    }
    Finally {
        If ($WorkingDirectory) {
            Pop-Location
        }
    }

    $IsPrint = -Not $NoEcho.IsPresent
    $IsBadExitCode = -Not $ValidCodes.Contains($ResCode)
    $Value = ""
    If ($Result.IsPresent -or $IsPrint -or $IsBadExitCode) {
        $Value = If ($Res) { $Res | Where-Object { $_ } | ForEach-Object { $_.ToString() } | Out-String } Else { "" }
    }

    If ($IsBadExitCode) {
        Write-Log "$Value"
        Write-Log "$Name exit code $ResCode" -Level Error
        throw [InvalidShellCodeException]::new($ResCode)
    }
    ElseIf ($IsPrint) {
        Write-Output $Value
    }
    
    RETURN $Value
}

class InvalidShellCodeException : System.Exception {
    [int]$ExitCode

    InvalidShellCodeException([int]$exitCode) : base("Bad exit code $exitCode") {
        $this.ExitCode = $exitCode
    }
}