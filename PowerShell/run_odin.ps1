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

$run = if ($Build) { "build" } else { "run" }
$flags = @()

# Determine output path and executable location
$output_path = $Out
$exe_loc = if ($Out -eq "" -or $Out -eq ".") { "-out=" } else { "-out=$Out\" }

# Determine source file and executable name
if ($File) {
    $Name = if ($Name) { "$Name\$File.odin" } else { "$File.odin" }
    $exe_loc += "$File.exe"
    $flags += "-file"
} else {
    $Name = if ($Name) { $Name } else { "." }
    $exe_loc += if ($Name -eq ".") { "main.exe" } else { "$Name.exe" }
}

# Create output directory if needed
if ($Out -and $Out -ne "." -and -not (Test-Path $output_path)) {
    New-Item -Path $output_path -ItemType Directory | Out-Null
}
if ($Out) { $flags += "-keep-executable" }

# Optimization flags
$flags += if ($Release) { "-o:speed" } else { @("-o:none", "-debug") }

# Optional flags
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
