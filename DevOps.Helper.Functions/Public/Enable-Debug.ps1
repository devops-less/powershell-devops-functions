function Enable-Debug {
    <#
    .SYNOPSIS
        Enables debug logging

    .FUNCTIONALITY
        CI/CD

    .DESCRIPTION
        Enables debug logging
    #>
    [CmdletBinding()]
    $Global:DebugPreference = 'Continue'
}