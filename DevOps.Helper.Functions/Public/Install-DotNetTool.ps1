function Install-DotNetTool {
    param(
        [string]$Name,
        [string]$Version
    )

    $Info = iex "dotnet tool list $Name -g"
    If ($LASTEXITCODE -eq 0) {
        If ((-Not $Version) -or ($Version -and $Info -match "$Name(\s+)$Version")) {
            Write-Log "dotnet tool $Name $Version is already installed." -Level Debug
            RETURN
        }
    }

    # TODO: Add to paths under unix?
    Write-Log "installing dotnet tool $Name..."
    $ARG = If ($Version) { "--version $Version" } Else { '' }
    Invoke-ShellCommand "dotnet tool install --global $Name $ARG" 'dotnet tool'
}
