
. Launcher for GTA IV + ASI loader

Normally you have to mess around with moving dsound.dll
in and out of the GTA directory during launch, this 
script handles all of that for you.

FIRST TIME SETUP

You need to double-click InstallLaunchAndPatchGTAIV.bat
once before using this script - this will make PowerShell
scripts executable on your system.

TRIDEF 3D SUPPORT

If you are using TriDef Ignition to get 3D (or Oculus Rift
compatibility), edit the LaunchAndPatchGTAIV.ps1 file and
change the line:

	$useTriDef = $false

to

	$useTriDef = $true

Enjoy!
