function Trace-Expression {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)][scriptblock]$Expression,
        [Parameter(ValueFromPipeline)][psobject[]]$InputObject,
        [string]$Name
    )

    Write-Log "$Name..."
    $Result = $null
    $stopWatch = New-Object -TypeName 'System.Diagnostics.Stopwatch'
    $stopWatch.Start()
    
    Try {
        if ($InputObject) {
            # Creating the '$_' variable.
            $dollarUn = New-Object -TypeName psvariable -ArgumentList @('_', $InputObject)

            $Result = $Expression.InvokeWithContext($null, $dollarUn, $null)
        }
        else {
            $Result = $Expression.InvokeReturnAsIs()
        }
    }
    Catch {
        exit 1
    }
    Finally {
        $stopWatch.Stop()
        Write-Log "$Name done [$($stopWatch.Elapsed.ToString("s\.ff"))s]"
    }
}
