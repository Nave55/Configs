param(
[string]$Name,
[switch]$Release,
[switch]$G3
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
clang $cpp_loc $cpp_vers @flags $debug_mode -o $exe_loc
. $exe_loc
