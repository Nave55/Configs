param(
[string]$Name,
[string]$Out,
[switch]$Verbose,
[switch]$Release,
[switch]$Build,
[switch]$Help
)

if ($Out -ne "") {
	if (-not (Test-Path -Path $Out -PathType Container)) {
		New-Item -Path $Out -ItemType Directory
	}		
}
$exe_loc = "$Out/$Name.exe"
if ($Out -eq "") { $exe_loc = "$Name.exe" }

$flags = @("c", "--verbosity:0", "--hints:off", "-o=$exe_loc")
$Name += ".nim"

if ($Verbose) { $flags = @("c", "-o=$exe_loc") }
if (!$Build) { $flags += "-r" }
if ($Release) { $flags += "-d:release" }

cls
if ($Help) { 
	Write-Host "Options: -Name, -Verbose, -Release, -Build, -Out" 
} else {
	if ($Verbose) {
		Write-Host "nim $flags $Name"
	}
	nim @flags $Name
}
