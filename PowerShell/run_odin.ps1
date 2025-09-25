param(
[string]$Name,
[string]$File,
[string]$Out,
[switch]$Release,
[switch]$Vet,
[switch]$Timings,
[switch]$MoreTimings,
[switch]$Windows,
[switch]$Build,
[switch]$Help,
[switch]$Verbose
)

$exe_loc = "-out=$Out"
$output_path = "$Out"
$flags = @()
$run = "run"

if ($Out -ne "") { $exe_loc += "\" }

if ($File -ne "") {
    if ($Name -eq "") {
        $exe_loc += "$File.exe"
        $Name = "$File.odin"
    } else {
		$output_path = "$Out"
		$exe_loc = "-out=$Out\$File.exe"
        $Name += "/$File.odin"
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

if ($Out -ne "") {
	if (-not (Test-Path -Path $output_path -PathType Container)) {
		New-Item -Path $output_path -ItemType Directory
	}		
	$flags += "-keep-executable"
}

if ($Release) {
    $flags += "-o:speed"
} else {
    $flags += "-o:none"
    $flags += "-debug"
}

if ($Build) { $run = "build" }
if ($Vet) { $flags += "-vet" }
if ($Timings) { $flags += "-show-timings" }
if ($MoreTimings) { $flags += "-show-more-timings" }
if ($Windows) { $flags += "-subsystem:windows" }
 
cls
if ($Help) { 
    Write-Host "Options: -Name, -File, -Build, -Release, -Out, -Vet, -Timings, -MoreTimings, -Windows, -Verbose" 
} else {
    if ($Verbose) { Write-Host "odin $run $Name $flags $exe_loc" }
    odin $run $Name @flags $exe_loc
}
