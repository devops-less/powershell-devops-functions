function Invoke-DotNetCheckVulnerabilities {
    param(
        [string]$Folder = (Get-Location).Path,
        [switch]$Transitive,
        [switch]$Interactive,
        [string[]]$Level = @('High', 'Critical'),
        [string]$AllowedFile = "allowed_vulnerabilities.json"
    )
    Test-Tool 'dotnet' -Assert
    Write-Log "dotnet check vulnerabilities..."
    Write-Log "Folder: $Folder" -Level Debug

    $AllowedFilePath = Join-Path $Folder $AllowedFile
    $Allowed = @{ packages = @(); vulnerabilities = @() }
    If (Test-Path "$AllowedFilePath") {
        $Allowed = Get-Content $AllowedFilePath -Raw | ConvertFrom-Json
    }

    $ProjOrSlnFile = Find-FirstFileByPattern -Path $Folder -Pattern "*.sln,*.csproj"
    Assert-Condition (Test-Path $ProjOrSlnFile) "solution or project file exists"
    $Arg1 = If ($Transitive.IsPresent) { '--include-transitive' } Else { '' }
    $Arg2 = If ($Interactive.IsPresent) { '--interactive' } Else { '' }
    $raw = Invoke-ShellCommand "dotnet list ${ProjOrSlnFile} package --format json --vulnerable $Arg1 $Arg2" 'dotnet audit' -WorkingDirectory $Folder -Result

    $Successful = $true
    $PackageNames = @()

    $allPackages = $raw | ConvertFrom-Json | Select-Object -ExpandProperty projects | Where-Object { $_.frameworks } | Select-Object -ExpandProperty frameworks | ForEach-Object { $_.topLevelPackages + $_.transitivePackages }
    $allPackages | ForEach-Object {
        $packages = $_
        $packages | ForEach-Object {
            $package = $_
            $key = "$($package.id)@$($package.resolvedVersion)"
            If ($PackageNames -contains $key) {
                RETURN
            }

            $PackageNames += $key
            $PackageSkip = $Allowed.packages -contains $key
            $package.vulnerabilities | ForEach-Object {
                $vulnerability = $_
                $LevelAllowed = (-Not ($Level -contains $vulnerability.severity))
                $VulnerabilityIgnore = $Allowed.vulnerabilities -contains $vulnerability.advisoryurl
                $Status = If ($PackageSkip) { "Skipped" } ElseIf ($LevelAllowed) { "Allowed" } ElseIf ($VulnerabilityIgnore) { "Ignore" } Else { "Vulnerable" }
                If ($Status -eq "Vulnerable") {
                    $Successful = $false
                }

                Write-Log "| $($key.PadRight(50)) | $($Status.PadRight(10)) | $($vulnerability.severity.PadRight(8)) | $($vulnerability.advisoryurl) |"
            }
        }
    }

    Assert-Condition ($Successful) "vulnerabilities"
}

enum PackageStatus {
    Vulnerable
    Allowed
    Ignore
    Skipped
}
