param(
[string]$Name,
[string]$File,
[switch]$Release,
[switch]$Keep,
[switch]$Vet,
[switch]$Timings,
[switch]$MoreTimings,
[switch]$Windows,
[switch]$Build,
[switch]$Help
)

$exe_loc = "-out=output\"
$flags = @()
$run = "run"

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
        $exe_loc += "main.exe"
    } else {
        $exe_loc += "$Name.exe"
    }
}


if ($Release) {
    $debug_mode = ""
    $flags += "-o:speed"
} else {
    $flags += "-o:none"
    $flags += "-debug"
}

if ($Build) { $run = "build" }
if ($Keep) { $flags += "-keep-executable" }
if ($Vet) { $flags += "-vet" }
if ($Timings) { $flags += "-show-timings" }
if ($MoreTimings) { $flags += "-show-more-timings" }
if ($Windows) { $flags += "-subsystem:windows" }
 
cls
if ($Help) { 
    Write-Host "Options: -Name, -File, -Build, -Release, -Keep, -Vet, -Timings, -MoreTimings, -Windows" 
}
else {
    Write-Host "odin $run $Name $flags $exe_loc $debug_mode"
    odin $run $Name @flags $exe_loc $debug_mode
}
