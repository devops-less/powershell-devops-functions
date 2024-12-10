function Invoke-NodeRestore {
    param(
        [string]$Folder,
        [PackageManagement]$PackageManagement = [PackageManagement]::Npm
    )

    Test-Tool 'node' -Assert
    If ($PackageManagement -eq [PackageManagement]::Npm) {
        $Command = 'npm install'
    } ElseIf ($PackageManagement -eq [PackageManagement]::Yarn) {
        Activate-Corepack 'yarn'
        $Command = 'yarn install'
    } ElseIf ($PackageManagement -eq [PackageManagement]::Pnpm) {
        Activate-Corepack 'pnpm'
        $Command = 'pnpm install'
    }
    Write-Log "node restore..."
    Invoke-ShellCommand $Command 'node restore' -WorkingDirectory $Folder
}

function Activate-Corepack {
    param(
        [string]$Package
    )
    Invoke-ShellCommand 'corepack enable' 'corepack enable'
    Invoke-ShellCommand "corepack prepare $Package --activate" 'corepack prepare'
}

enum PackageManagement {
    Npm
    Yarn
    Pnpm
}
