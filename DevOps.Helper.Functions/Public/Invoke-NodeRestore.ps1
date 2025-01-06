function Invoke-NodeRestore {
    param(
        [string]$Folder,
        [PackageManagement]$PackageManagement = [PackageManagement]::Npm,
        [string]$CacheFolder,
        [switch]$OmitOptional,
        [switch]$CI
    )

    Test-Tool 'node' -Assert
    Write-Log "node restore..."
    If ($PackageManagement -eq [PackageManagement]::Npm) {
        $N0 = If ($CI.IsPresent) { 'npm ci' } else { 'npm i' }
        $N1 = If ($CacheFolder) { "--cache $CacheFolder" } else { '' }
        $N2 = If ($OmitOptional.IsPresent) { '--omit=optional' } else { '' }
        Invoke-ShellCommand "$N0 $N1 $N2 --prefer-offline --no-audit" -WorkingDirectory $Folder
    }
    ElseIf ($PackageManagement -eq [PackageManagement]::Yarn) {
        Activate-Corepack 'yarn'
        Invoke-ShellCommand $Command 'yarn install' -WorkingDirectory $Folder
    }
    ElseIf ($PackageManagement -eq [PackageManagement]::Pnpm) {
        Activate-Corepack 'pnpm'
        If ($CacheFolder) {
            Invoke-ShellCommand "pnpm config set store-dir $CacheFolder" -WorkingDirectory $Folder
        }

        $P1 = If ($CI.IsPresent) { '--frozen-lockfile' } else { '' }
        $P2 = If ($OmitOptional.IsPresent) { '--no-optional' } else { '' }
        Invoke-ShellCommand $Command "pnpm i $P1 $P2 --prefer-offline" -WorkingDirectory $Folder
    }
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
