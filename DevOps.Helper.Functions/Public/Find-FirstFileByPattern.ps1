function Find-FirstFileByPattern {
    param(
        [string]$Path,
        [string]$Pattern
    )
    $Patterns = $Pattern -split ','
    ForEach ($P in $Patterns) {
        $Files = Get-ChildItem -Path $Path -Filter $P -File
        If ($Files) {
            BREAK
        }
    }

    RETURN $Files | Select-Object -First 1 -ExpandProperty FullName
}
