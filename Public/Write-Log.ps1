function Write-Log {
    <#
    .SYNOPSIS
        Logs a debug, info, or error message to the console

    .FUNCTIONALITY
        CI/CD

    .DESCRIPTION
        Logs a debug, info, or error message to the console

    .PARAMETER Msg
        The message to log

    .PARAMETER Level
        The level of the message.  Options are Error, Info, and Debug

    .EXAMPLE
        Log-Msg "This is an error message" -Level Error

    .LINK
        https://github.com/rosenkolev/DevOpsScripts
    #>
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)][string]$Msg,
        [LogLevels]$Level = [LogLevels]::Info
    )
    If ($Msg.Length -ne 0)  {
    If ($Level -eq [LogLevels]::Error) {
        Write-Host $Msg -ForegroundColor Red
    }
    ElseIf ($Level -eq [LogLevels]::Info) {
        Write-Host $Msg
    }
    Else {
        Write-Debug $Msg
    }
    }
}

enum LogLevels {
    Error = 1
    Info
    Debug
}
