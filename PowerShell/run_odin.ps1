param(
[string]$Name,
[string]$File,
[switch]$Release,
[switch]$Test,
[switch]$Keep,
[switch]$Vet,
[switch]$Timings,
[switch]$MoreTimings
)

$exe_loc = "-out=output\$Name.exe"
$run_type = "run"
$flags = @()

if ($File -ne "") {
    $Name += ("/" + $File + ".odin")
    $flags += "-file"
}

if ($Release) {
    $debug_mode = ""
    $flags += "-o:speed"
} else {
    $flags += "-o:none"
    $flags += "-debug"
}

if ($Test) {
    $run_type = "test"
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
odin $run_type $Name $flags $exe_loc $debug_mode
