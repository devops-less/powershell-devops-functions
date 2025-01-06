function Add-TrailingSlash {
    param(
        [Parameter(Position = 0)][string]$Path
    )
    if ($Path[-1] -ne '\' -and $Path[-1] -ne '/') {
        RETURN "$($Path)$([System.IO.Path]::DirectorySeparatorChar)"
    }
    RETURN $Path
}
