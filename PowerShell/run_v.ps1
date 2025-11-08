param(
[string]$Name,
[string]$Dir,
[string]$Out,
[switch]$Release,
[switch]$G,
[switch]$Verbose,
[switch]$Help
)

if ($Out -ne "") {
	if (-not (Test-Path -Path $Out -PathType Container)) {
		New-Item -Path $Out -ItemType Directory
	}
}

$flags = @()
$exe_loc = "$Out\$Name.exe"
$name_path = "$Name"

if ($Dir -ne "") { $name_path = "$Dir\$Name" }
if ($Out -eq "") { $exe_loc = "$Name.exe" }
if ($G) { $flags += "-g" }


if ($Release) {
    if ($Out -ne "") {
      $flags = @("-prod", "-o", $exe_loc, "crun")
    } else {
      $flags = @("-prod", "run")
    }
} else {
    if ($Out -ne "") {
      $flags = @("-o", $exe_loc, "crun")
    } else {
      $flags += "run"
    }
}

cls
if ($Help) {
	Write-Host "Options: -Name, -Dir, -Out, -Release, -G, -Verbose"
} else {
	if ($Verbose) {
		Write-Host "v $flags $Name"
	}
    v @flags $name_path
}
