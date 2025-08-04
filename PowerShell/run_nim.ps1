param(
[string]$Name,
[switch]$Verbose,
[switch]$Release
)

$exe_loc = "output\$Name.exe"
$flags = @("c", "--verbosity:0", "--hints:off", "-o=output/$Name.exe", "-r")
$Name += ".nim"

if ($Verbose) {
	$flags = @("c", "-o=output/$Name.exe", "-r")
}

if ($Release) {
    $flags += "-d:release"
}

cls
nim @flags $Name
