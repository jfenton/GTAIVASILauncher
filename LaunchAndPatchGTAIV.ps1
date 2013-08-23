
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

$useTriDef = $true

Function Err($msg) {
	[System.Windows.Forms.MessageBox]::Show($msg, "Error", 0)
	exit
}

$steamAppsCommonDir = (Get-Item HKCU:\Software\Valve\Steam).GetValue("SteamPath") + "/steamapps/common"
$gtaDir = "$steamAppsCommonDir/Grand Theft Auto IV/GTAIV"

if ($useTriDef) {
	$triDef = (Get-Item HKLM:\SOFTWARE\Classes\TriDefGame\Shell\Open\command).GetValue("")
	$triDef -match '\"([^"+]+)\"' | Out-Null
	$triDefExe = $($matches[1])

	if (!(Test-Path $triDefExe)) {
		Err "Error: Unable to locate your TriDef 3D Ignition executable at $triDefExe (derived from registry)"
	}

	$launchGTA = $triDefExe
	$launchGTAArgs = @('-a', 'Grand Theft Auto IV')
} else {
	$gtaExe = "$gtaDir/LaunchGTAIV.exe"
	if (!(Test-Path $gtaExe)) {
		Err "Error: Unable to locate LaunchGTAIV.exe at $gtaExe"
	}
	$launchGTA = "$gtaExe"
	$launchGTAArgs = @()
}

if (Test-Path $gtaDir/dsound.dll) {
	Rename-Item $gtaDir\dsound.dll $gtaDir\dsound.dll.tmp
} elseif (Test-Path $gtaDir/dsound.dll.tmp) {
} else {
	Err "Error: Unable to locate dsound.dll or dsound.dll.tmp in your GTA IV directory! ($gtaDir)"
}

& $launchGTA $launchGTAArgs

start-sleep -seconds 3

$timeout = new-timespan -Seconds 30
$sw = [diagnostics.stopwatch]::StartNew()
while ($sw.elapsed -lt $timeout){
	$gtaRunning = Get-Process LaunchGTAIV -ErrorAction SilentlyContinue
	if($gtaRunning -eq $null) {
		Err "Error: Found $gtaExe, but on running it exited!"
	}

	$socialClubWindowExists = Get-Process | Where-Object {$_.MainWindowTitle.contains("Social Club")} | Select-Object MainWindowTitle

	if($socialClubWindowExists) {
		Rename-Item $gtaDir\dsound.dll.tmp $gtaDir\dsound.dll
		return
	}
	start-sleep -seconds 1
}

Err "Error: Unable to find the GTA Social Club window within 30 seconds!"
Rename-Item $gtaDir\dsound.dll.tmp $gtaDir\dsound.dll
