if (-not (Test-Path "C:\Users\Public\Desktop\Kronos.url"))
{
$null = $WshShell = New-Object -comObject WScript.Shell
$path = "C:\Users\Public\Desktop\Kronos.url"
$targetpath = "https://secure4.saashr.com/ta/6161089.login"
#$iconlocation = "C:\ProgramData\AutoPilotConfig\Icons\KronosIcon.ico"
$iconfile = "IconFile=" + $iconlocation
$Shortcut = $WshShell.CreateShortcut($path)
$Shortcut.TargetPath = $targetpath
$Shortcut.Save()

Add-Content $path "HotKey=0"
#Add-Content $path "$iconfile"
#Add-Content $path "IconIndex=0"
}