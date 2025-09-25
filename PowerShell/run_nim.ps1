param(
[string]$Name,
[switch]$Verbose,
[switch]$Release,
[switch]$Out,
[switch]$Build,
[switch]$Help,
)

if ($Out -ne "") {
	if (-not (Test-Path -Path $Out -PathType Container)) {
		New-Item -Path $Out -ItemType Directory
	}		
}

$flags = @("c", "--verbosity:0", "--hints:off", "-o=$Out/$Name.exe")
$Name += ".nim"

if (!$Build) { $flags += "-r" }
if ($Verbose) { $flags = @("c", "-o=$Out/$Name.exe", "-r") }
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
