function Invoke-DotNetLinting {
    param(
        [string]$Folder,
        [switch]$CSharpier
    )
    Write-Log "dotnet linting..."
    Test-Tool 'dotnet' -Assert

    If ($CSharpier.IsPresent) {
        Write-Log "csharpier linting..."
        Install-DotNetTool 'csharpier'
        Invoke-ShellCommand "dotnet csharpier --check ." 'csharpier' -WorkingDirectory $Folder
    }

    Write-Log "check dotnet format whitespace..."
    Invoke-ShellCommand "dotnet format whitespace --verify-no-changes" 'dotnet format workspace' -WorkingDirectory $Folder
    Write-Log "check dotnet format style..."
    Invoke-ShellCommand "dotnet format style --verify-no-changes" 'dotnet format style' -WorkingDirectory $Folder
    Write-Log "check dotnet format analyzers..."
    Invoke-ShellCommand "dotnet format analyzers --verify-no-changes" 'dotnet format analyzers' -WorkingDirectory $Folder
}