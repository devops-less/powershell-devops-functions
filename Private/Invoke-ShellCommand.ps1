function Invoke-ShellCommand {
    param(
        [Parameter(Position = 0, Mandatory)][string]$Command,
        [Parameter(Position = 1)][string]$Name = '',
        [string]$WorkingDirectory,
        [switch]$Result,
        [switch]$NoEcho
    )

    If ($WorkingDirectory) {
        Write-Log "Directory: $WorkingDirectory" -Level Debug
        Push-Location $WorkingDirectory
    }

    Write-Log "$Command" -Level Debug
    Try {
        $Res = iex $Command
        Assert-Condition ($LASTEXITCODE -eq 0) "$Name" -ExitCode $LASTEXITCODE
    }
    Catch {
        Write-Error $PSItem.ToString()
        throw $PSItem
    }
    Finally {
        If ($WorkingDirectory) {
            Pop-Location
        }

        If (($Result.IsPresent -or (-Not $NoEcho.IsPresent)) -and $Res) {
            $Value = $Res | Where-Object { $_ } | ForEach-Object { $_.ToString() } | Out-String
            If ($Print.IsPresent) {
                Write-Log $Value
            }
        }
    }

    RETURN $Value
}
