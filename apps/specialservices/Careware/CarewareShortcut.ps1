if (-not (Test-Path "C:\Users\Public\Desktop\Careware.url"))
{
$null = $WshShell = New-Object -comObject WScript.Shell
$path = "C:\Users\Public\Desktop\Careware.url"
$targetpath = "https://careware.adh.arkansas.gov/careware/rs/index.htm"
#$iconlocation = "C:\ProgramData\AutoPilotConfig\Icons\CarewareIcon.ico"
$iconfile = "IconFile=" + $iconlocation
$Shortcut = $WshShell.CreateShortcut($path)
$Shortcut.TargetPath = $targetpath
$Shortcut.Save()

Add-Content $path "HotKey=0"
Add-Content $path "$iconfile"
Add-Content $path "IconIndex=0"
}