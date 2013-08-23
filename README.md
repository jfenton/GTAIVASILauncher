
Launcher for GTA IV + ASI loader
--------------------------------

Normally you have to mess around with moving dsound.dll
in and out of the GTA directory during launch, this 
script handles all of that for you.

FIRST TIME SETUP

1. Copy all files into your GTA IV directory.

2. You need to double-click InstallLaunchAndPatchGTAIV.bat once before using this script - this will make PowerShell scripts executable on your system.

HOW TO USE

Just double-click LaunchAndPatchGTAIV.vbs and the game will start.

It will move the dsound.dll out of the way whilst it starts, and then when the Social Club window appears, copy the file back (in the background).

TRIDEF 3D SUPPORT

If you are using TriDef Ignition to get 3D (or Oculus Rift
compatibility), edit the LaunchAndPatchGTAIV.ps1 file and
change the line:

	$useTriDef = $false

to

	$useTriDef = $true

Enjoy!
