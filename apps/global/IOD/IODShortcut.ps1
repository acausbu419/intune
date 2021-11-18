if (-not (Test-Path "C:\Users\Public\Desktop\IOD.url"))
{
$null = $WshShell = New-Object -comObject WScript.Shell
$path = "C:\Users\Public\Desktop\IOD.url"
$targetpath = "https://west.intergyhosted.com"
$iconlocation = "C:\ProgramData\AutoPilotConfig\Icons\IODIcon.ico"
$iconfile = "IconFile=" + $iconlocation
$Shortcut = $WshShell.CreateShortcut($path)
$Shortcut.TargetPath = $targetpath
$Shortcut.Save()

Add-Content $path "HotKey=0"
Add-Content $path "$iconfile"
Add-Content $path "IconIndex=0"
}