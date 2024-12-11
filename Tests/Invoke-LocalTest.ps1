param(
    [string]$TestPath
)

Import-Module "$PSScriptRoot\..\DevOps.Helper.Functions.psm1" -Force -Verbose
if (-Not (Get-Module -Name DevOps.Helper.Functions)) {
    Write-Error "Failed to load the module."
    exit 1
}

Enable-Debug

Invoke-SecretLint -Path "$TestPath"
Invoke-CSpell -Path "$TestPath"

# Test the function
# Invoke-EcLint -Path "$TestPath"
# Invoke-EcLint -Path "$TestPath" -GitFilesOnly
