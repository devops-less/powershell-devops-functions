function Invoke-DotNetLinting {
    param(
        [string]$Folder,
        [switch]$CSharpier
    )
    Write-Log "dotnet linting..."
    Test-Tool 'dotnet' -Assert

    If ($CSharpier.IsPresent) {
        Trace-Expression -Name 'csharpier check' {
            Install-DotNetTool 'csharpier'
            Invoke-ShellCommand "dotnet csharpier --check ." 'csharpier' -WorkingDirectory $Folder
        }
    }

    Trace-Expression -Name 'dotnet format whitespace' {
        Invoke-ShellCommand "dotnet format whitespace --verify-no-changes" 'dotnet format workspace' -WorkingDirectory $Folder
    }
    Trace-Expression -Name 'dotnet format style' {
        Invoke-ShellCommand "dotnet format style --verify-no-changes" 'dotnet format style' -WorkingDirectory $Folder
    }
    Trace-Expression -Name 'dotnet format analyzers' {
        Invoke-ShellCommand "dotnet format analyzers --verify-no-changes" 'dotnet format analyzers' -WorkingDirectory $Folder
    }
}