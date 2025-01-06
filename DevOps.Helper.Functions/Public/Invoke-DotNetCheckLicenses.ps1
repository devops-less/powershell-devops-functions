function Invoke-DotNetCheckLicenses {
    param(
        [string]$Folder = (Get-Location).Path
    )
    $WD = Add-TrailingSlash -Path $Folder

    Test-Tool 'dotnet' -Assert
    Trace-Expression -Name 'dotnet license check' {
        Install-DotNetTool 'dotnet-project-licenses'
        $File = Get-ChildItem -Path $Folder -Filter "*.sln" | Select-Object -First 1 -ExpandProperty FullName
        Assert-Condition (Test-Path "$($WD)allowed_licenses.json") "$($WD)allowed_licenses.json exists"
        Assert-Condition (Test-Path $File) "solution file exists"

        Invoke-ShellCommand "dotnet-project-licenses -i ""$File"" -t --use-project-assets-json --allowed-license-types ""$($WD)allowed_licenses.json"" -u -m" 'dotnet-project-licenses' -WorkingDirectory $WD
    }
}
