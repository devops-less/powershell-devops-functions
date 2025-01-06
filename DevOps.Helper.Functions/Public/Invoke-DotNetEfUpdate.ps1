function Invoke-DotNetEfUpdate {
    param(
        [string]$Folder,
        [Parameter(Mandatory)][string]$ConnectionString
    )
    Test-Tool 'dotnet' -Assert
    Install-DotNetTool 'dotnet-ef'
    Trace-Expression -Name 'dotnet ef update' {
        Invoke-ShellCommand "dotnet ef database update -connection=""$ConnectionString""" 'dotnet ef update' -WorkingDirectory $Folder
    }
}
