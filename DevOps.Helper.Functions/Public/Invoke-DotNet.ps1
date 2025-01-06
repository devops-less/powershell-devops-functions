function Invoke-DotNet {
    param(
        [Parameter(Position = 0)][string]$File,
        [string]$LocalPackagesStore,
        [string]$Configuration = 'Release',
        [switch]$LockedMode,
        [switch]$Restore,
        [switch]$Build,
        [switch]$Publish,
        [switch]$Test,
        [string]$TestName = 'unit-tests',
        [switch]$JunitReport,
        [switch]$TrxReport,
        [string]$ResultsDirectory = "$((Get-Location).Path)\TestResults",
        [switch]$CoberturaReport,
        [switch]$OpenCoverReport,
        [string]$CoverageExclude = '**/Migrations/**',
        [switch]$Pack,
        [string]$Output
    )
    Test-Tool 'dotnet' -Assert

    If ($Restore.IsPresent) {
        Trace-Expression -name 'dotnet restore' {
            $R1 = If ($LockedMode.IsPresent) { ' --locked-mode' } Else { '' }
            $R2 = If ($LocalPackagesStore) { " --packages $LocalPackagesStore" } Else { '' }
            Invoke-ShellCommand "dotnet restore $($File)$($R1)$($R2) " 'dotnet restore'
        }
    }
    If ($Build.IsPresent) {
        Trace-Expression -name 'dotnet build' {
            Invoke-ShellCommand "dotnet build $($File) --no-restore --nologo -c $Configuration" 'dotnet build'
        }
    }
    If ($Publish.IsPresent) {
        Write-Log "dotnet publish..."
        Invoke-ShellCommand "dotnet publish $($File) --no-build --no-restore --nologo -c $Configuration" 'dotnet publish'
    }
    If ($Test.IsPresent) {
        $ResultsDirectory = Add-TrailingSlash $ResultsDirectory
        Write-Log "dotnet test..."
        $T1 = If ($JunitReport.IsPresent) { "-l ""junit;LogFileName=$TestName.results.xml;MethodFormat=Class;FailureBodyFormat=Verbose""" } Else { '' }
        $T2 = If ($TrxReport.IsPresent) { "-l ""trx;LogFileName=$TestName.results.trx""" } Else { '' }
        $T3 = If ($CoberturaReport.IsPresent -and $OpenCoverReport.IsPresent) { "cobertura,opencover" } ElseIf ($CoberturaReport.IsPresent) { "cobertura" } ElseIf ($OpenCoverReport.IsPresent) { "opencover" } Else { '' }
        $T4 = If ($T3) { "-p:CollectCoverage=true -e:CoverletOutputFormat=""$T3"" -e:ExcludeByFile=""$CoverageExclude"" -e:CoverletOutput=""$ResultsDirectory""" } Else { '' }
        Invoke-ShellCommand "dotnet test $($File) --no-build --no-restore --nologo -c $Configuration $($T1) $($T2) --results-directory $ResultsDirectory $($T4)" 'dotnet test'
    }
    If ($Pack.IsPresent) {
        Write-Log "dotnet pack..."
        $P1 = If ($Output) { "-o $Output" } Else { '' }
        Invoke-ShellCommand "dotnet pack $($File) --no-build --no-restore --nologo -c $Configuration $P1" 'dotnet pack'
    }
}
