function Invoke-EcLint {
    <#
    .SYNOPSIS
      Lint files using `eclint` .editorconfig lint.
    #>
    param(
        [string]$Path,
        [switch]$GitFilesOnly
    )

    Test-Tool 'npx' -Assert
    
    $Pattern = If ($GitFilesOnly.IsPresent) { """$((Get-GitFiles -Path $Path) -join '" "')""" } else { '' }
    
    Trace-Expression -Name 'eclint lint' {   
        Invoke-ShellCommand "npx -y eclint check $Pattern" 'eclint' -WorkingDirectory $Path
    }
}
