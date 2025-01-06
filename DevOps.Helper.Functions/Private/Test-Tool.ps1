function Test-Tool {
    param(
        [Parameter(Mandatory)][string]$ToolName,
        [switch]$Assert
    )

    If ($GlobalCachedToolResults.ContainsKey($ToolName)) {
        $Result = $GlobalCachedToolResults[$ToolName]
    }
    Else {
        $oldPreference = $ErrorActionPreference
        $ErrorActionPreference = 'stop'
        try {
            if(Get-Command $ToolName) {
                $Result = $GlobalCachedToolResults[$ToolName] = $true
            }
        }
        Catch {
            $Result = $GlobalCachedToolResults[$ToolName] = $false
        }
        Finally {
            $ErrorActionPreference=$oldPreference
        }
    }

    If ($Result -eq $true) {
        Write-Log "$ToolName exists" -Level Debug
    }
    Else {
        Write-Log "$ToolName don't exist" -Level Debug
    }

    If ($Assert.IsPresent) {
        Assert-Condition $Result  "$ToolName exists"
    }
    Else {
      RETURN $Result  
    }
}

$GlobalCachedToolResults = @{}
