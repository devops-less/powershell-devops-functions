function Assert-Condition {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)][bool]$Condition,
        [Parameter(Position = 1, Mandatory)][string]$Name,
        [int]$ExitCode = 1
    )

    If ($Condition) {
        Write-Log "$Name succeeded." -Level Debug
    }
    Else {
        Write-Log "$Name failed" -Level Error
        exit $ExitCode
    }
}
