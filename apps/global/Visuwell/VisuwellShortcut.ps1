if (-not (Test-Path "C:\Users\Public\Desktop\Visuwell.url"))
{
$null = $WshShell = New-Object -comObject WScript.Shell
$path = "C:\Users\Public\Desktop\Visuwell.url"
$targetpath = "https://virtualcarenow.arcare.net"
#$iconlocation = "C:\ProgramData\AutoPilotConfig\Icons\VisuwellIcon.ico"
$iconfile = "IconFile=" + $iconlocation
$Shortcut = $WshShell.CreateShortcut($path)
$Shortcut.TargetPath = $targetpath
$Shortcut.Save()

Add-Content $path "HotKey=0"
#Add-Content $path "$iconfile"
#Add-Content $path "IconIndex=0"
}