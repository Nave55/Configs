param(
[string]$Name,
[string]$File,
[switch]$Release,
[switch]$Keep,
[switch]$Vet,
[switch]$Timings,
[switch]$MoreTimings
)

$exe_loc = "-out=output\"
$flags = @()

if ($File -ne "") {
    if ($Name -eq "") {
        $exe_loc += "$File.exe"
        $Name = "$File.odin"
    } else {
        $exe_loc = "-out=$Name\output\$File.odin"
        $Name += "\$File.odin"
    }
    $flags += "-file"
} else {
    if ($Name -eq "") {
        $Name = "."
    }
    $exe_loc += "main.exe"
}

if ($Release) {
    $debug_mode = ""
    $flags += "-o:speed"
} else {
    $flags += "-o:none"
    $flags += "-debug"
}

if ($Keep) {
    $flags += "-keep-executable"
}

if ($Vet) {
    $flags += "-vet"
}

if ($Timings) {
    $flags += "-show-timings"
}

if ($MoreTimings) {
    $flags += "-show-more-timings"
}
 
cls
Write-Host "odin run $Name $flags $exe_loc $debug_mode"
odin run $Name $flags $exe_loc $debug_mode
