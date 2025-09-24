param(
[string]$Name,
[string]$File,
[string]$Out,
[switch]$Release,
[switch]$Keep,
[switch]$Vet,
[switch]$Timings,
[switch]$MoreTimings,
[switch]$Windows,
[switch]$Build,
[switch]$Help
)

$exe_loc = "-out=$Out"
$output_path = "$Out"
$flags = @()
$run = "run"

if ($Out -ne "") { exe_loc += "\" }

if ($File -ne "") {
    if ($Name -eq "") {
        $exe_loc += "$File.exe"
        $Name = "$File.odin"
    } else {
		$output_path = "$Name\$Out"
		$exe_loc = "-out=$Name\$Out\$File.exe"
        $Name += "$File.odin"
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

if ($Keep -and $Out -ne "") {
	if (-not (Test-Path -Path $output_path -PathType Container)) {
		New-Item -Path $output_path -ItemType Directory
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
    Write-Host "Options: -Name, -File, -Build, -Release, -Out, -Keep, -Vet, -Timings, -MoreTimings, -Windows" 
}
else {
    Write-Host "odin $run $Name $flags $exe_loc $debug_mode"
    odin $run $Name @flags $exe_loc $debug_mode
}
