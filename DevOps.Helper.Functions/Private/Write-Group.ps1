function Write-Group {
    param (
        [Parameter(Mandatory, Position = 0)][string]$Title,
        [switch]$End
    )

    if ($EnvId -eq [HostEnvs]::None) {
        $EnvId = If ($env:GITHUB_ACTIONS -eq $true) { [HostEnvs]::GitHub } ElseIf ($env:GITLAB_CI -eq $true) { [HostEnvs]::GitLab } Else { [HostEnvs]::Other }
    }
    if (-not $End.IsPresent) {
        If ($EnvId -eq "GitHub") {
            Write-Output "::group::$Title"
        }
        ElseIf ($EnvId -eq "GitLab") {
            $key = $Title.ToLowerInvariant().Replace(" ", "_")
            Write-Output "$([char]27)[0Ksection_start:$(GetTime):$key$([char]13)$([char]27)[0K$Title"
        }
        Else {
            Write-Output "[$Title] start"
        }
    }
    Else {
        If ($EnvId -eq "GitHub") {
            Write-Output "::endgroup::"
        }
        ElseIf ($EnvId -eq "GitLab") {
            $key = $Title.ToLowerInvariant().Replace(" ", "_")
            Write-Output "$([char]27)[0Ksection_end:$(GetTime):$($key)$([char]13)$([char]27)[0K"
        }
        Else {
            Write-Output "[$Title] end"
        }
    }
}

enum HostEnvs {
    None = 0
    GitHub = 1
    GitLab
    Other
}

$EnvId = [HostEnvs]::None
