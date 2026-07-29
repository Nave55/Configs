param(
[string]$Name,
[string]$File,
[string]$Out,
[string]$Speed,
[switch]$Release,
[switch]$Debug,
[switch]$Vet,
[switch]$San,
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

if ($Out -ne "" -and $Out -ne ".") { $exe_loc += "\" }

if ($Out -ne "") {
	if ($Out -ne ".") {
		if (-not (Test-Path -Path $output_path -PathType Container)) {
			New-Item -Path $output_path -ItemType Directory
		}
	} else {
        $exe_loc = "-out="
    }
    
	$flags += "-keep-executable"
}

if ($File -ne "") {
    if ($Name -eq "") {
        $exe_loc += "$File.exe"
        $Name = "$File.odin"
    } else {
		$output_path = "$Out"
		$exe_loc = "-out=$Out\$File.exe"
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


if ($Speed -eq "") {
    if ($Release) {
        $flags += "-o:speed"
    } else {
        $flags += "-o:minimal"
    }
} else {
    $flags += "-o:$($Speed)"
}


if ($Debug) { $flags += "-debug" }
if ($Build) { $run = "build" }
if ($Vet) { $flags += "-vet" }
if ($San) { $flags += "-sanitize:address" }
if ($Timings) { $flags += "-show-timings" }
if ($MoreTimings) { $flags += "-show-more-timings" }
if ($Windows) { $flags += "-subsystem:windows" }
 
cls
if ($Help) { 
    Write-Host "Options: -Name, -File, -Build, -Release, -Debug, -Speed, -Out, -Vet, -San, -Timings, -MoreTimings, -Windows, -Verbose" 
} else {
    if ($Verbose) { Write-Host "odin $run $Name $flags $exe_loc" }
    odin $run $Name @flags $exe_loc
}
