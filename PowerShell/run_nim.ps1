param(
[string]$Name,
[switch]$Verbose,
[switch]$Release,
[switch]$Build,
[switch]$Help
)

$exe_loc = "output\$Name.exe"
$flags = @("c", "--verbosity:0", "--hints:off", "-o=output/$Name.exe")
$Name += ".nim"

if (!$Build) {
	$flags += "-r"
}

if ($Verbose) {
	$flags = @("c", "-o=output/$Name.exe", "-r")
}

if ($Release) {
    $flags += "-d:release"
}

cls
if ($Help) { 
	Write-Host "Options: -Name, -Verbose, -Release, -Build" 
} else {
	Write-Host "nim $flags $Name"
	nim @flags $Name
}
