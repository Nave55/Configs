param(
[string]$Name,
[string]$Out,
[switch]$Release,
[switch]$G3,
[switch]$Build,
[switch]$Help,
[switch]$Verbose
)

$cpp_loc = ".\$Name.cpp"
$exe_loc = "$Out\$Name.exe"
$cpp_vers = "-std=gnu++2c"
$flags = @("-O0", "-Wextra", "-Wall")
$debug_mode = "-DDEBUG"

if ($Out -ne "") {
	if (-not (Test-Path -Path $Out -PathType Container)) {
		New-Item -Path $Out -ItemType Directory
	}
} else {
	$exe_loc = "$Name.exe"
}


if ($Release) {
    $debug_mode = "-DRELEASE"
    $flags = @("-O3")
}

if ($G3) { $flags += "-g3" }

cls
if ($Help) {
    Write-Host "Options: -Name, -Release, -Build, -G3, -Verbose" 
} else {
	if ($Verbose) { Write-Host "clang $cpp_loc $cpp_vers $flags $debug_mode -o $exe_loc" }
    clang $cpp_loc $cpp_vers @flags $debug_mode -o $exe_loc
    if (!$Build) { & ".\$($exe_loc)" }
}
