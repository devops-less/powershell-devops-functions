function Invoke-NodeGlobalInstall {
    param(
        [string]$PackageName,
        [string]$Version
    )

    Test-Tool 'npm' -Assert
    Write-Log "check $PackageName" -Level Debug
    $Pck = If ($Version) { "$PackageName@$Version" } else { $PackageName }
    $NOOP = iex "npm list -g --depth=0 $Pck"
    If ($LASTEXITCODE -eq 0) {
        Write-Log "$PackageName is already installed." -Level Debug
    }
    Else {
        Write-Log "install $PackageName..." -Level Debug
        Invoke-ShellCommand "npm install -g $Pck" 'npm global install'
    }
}
