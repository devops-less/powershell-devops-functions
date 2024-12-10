function Test-Tool {
    param(
        [Parameter(Mandatory)][string]$ToolName,
        [switch]$Assert
    )

    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try {
        if(Get-Command $ToolName) {
            Write-Log "$ToolName exists" -Level Debug
            If (-Not $Assert.IsPresent) {
                RETURN $true   
            }
        }
    }
    Catch {
        Write-Log "$ToolName does not exist" -Level Debug
        If ($Assert.IsPresent) {
            Assert-Condition $false "$ToolName exists"
        }
        Else {
            RETURN $false
        }
    }
    Finally {
        $ErrorActionPreference=$oldPreference
    }
}
