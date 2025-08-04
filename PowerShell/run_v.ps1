param(
[string]$Name,
[switch]$Release,
[switch]$G
)

$exe_loc = "output\$Name.exe"
$flags = @()

if ($G) {
    $flags += "-g"
}

if ($Release) {
    $flags = @("-prod", "-o", $exe_loc, "crun")
} else {
    $flags += "run"
}

v @flags $Name
