param(
[string]$Name,
[switch]$Release,
[switch]$G,
[switch]$Help
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

cls
if ($Help) { 
	Write-Host "Options: -Name, -Release, -G" 
} else {
    v @flags $Name
}
