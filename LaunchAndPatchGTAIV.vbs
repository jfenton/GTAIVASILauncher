Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "PowerShell .\LaunchAndPatchGTAIV.ps1"
oShell.Run strArgs, 0, false
