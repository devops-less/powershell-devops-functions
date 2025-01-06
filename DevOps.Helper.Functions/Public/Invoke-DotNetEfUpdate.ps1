function Invoke-DotNetEfUpdate {
    param(
        [string]$Folder,
        [Parameter(Mandatory)][string]$ConnectionString
    )
    Test-Tool 'dotnet' -Assert
    Install-DotNetTool 'dotnet-ef'
    Write-Log "dotnet ef update..."
    Invoke-ShellCommand "dotnet ef database update -connection=""$ConnectionString""" 'dotnet ef update' -WorkingDirectory $Folder
}
