$scriptPath = "$PSScriptRoot/src"

foreach ($script in Get-ChildItem -Path $scriptPath -Filter *.ps1 -Recurse) {
    . $script.FullName
}