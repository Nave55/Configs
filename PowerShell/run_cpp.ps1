param(
[string]$Name,
[switch]$Release,
[switch]$G3,
[switch]$Build,
[switch]$Help
)

$cpp_loc = ".\$Name.cpp"
$exe_loc = "output\$Name.exe"
$cpp_vers = "-std=gnu++2c"
$flags = @("-O0", "-Wextra", "-Wall")
$debug_mode = "-DDEBUG"

if ($Release) {
    $debug_mode = "-DRELEASE"
    $flags = @("-O3")
}

if ($G3) {
    $flags += "-g3"
}

cls
if ($Help) {
    Write-Host "Options: -Name, -Release, -G3" 
} else {
    Write-Host "clang $cpp_loc $cpp_vers $flags $debug_mode -o $exe_loc"
    clang $cpp_loc $cpp_vers @flags $debug_mode -o $exe_loc
    if (!$Build) {
        . $exe_loc
    }
}
