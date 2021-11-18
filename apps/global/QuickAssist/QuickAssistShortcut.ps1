if (-not (Test-Path "C:\Users\Public\Desktop\QuickAssist.lnk"))
{
$null = $WshShell = New-Object -comObject WScript.Shell
$path = "C:\Users\Public\Desktop\QuickAssist.lnk"
$targetpath = "%windir%\system32\quickassist.exe"
#$iconlocation = "C:\ProgramData\AutoPilotConfig\Icons\QuickAssistIcon.ico"
$iconfile = "IconFile=" + $iconlocation
$Shortcut = $WshShell.CreateShortcut($path)
$Shortcut.TargetPath = $targetpath
$Shortcut.Save()

Add-Content $path "HotKey=0"
#Add-Content $path "$iconfile"
#Add-Content $path "IconIndex=0"
}