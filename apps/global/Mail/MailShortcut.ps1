if (-not (Test-Path "C:\Users\Public\Desktop\Mail.url"))
{
$null = $WshShell = New-Object -comObject WScript.Shell
$path = "C:\Users\Public\Desktop\Mail.url"
$targetpath = "https://outlook.office.com/"
#$iconlocation = "C:\ProgramData\AutoPilotConfig\Icons\MailIcon.ico"
$iconfile = "IconFile=" + $iconlocation
$Shortcut = $WshShell.CreateShortcut($path)
$Shortcut.TargetPath = $targetpath
$Shortcut.Save()

Add-Content $path "HotKey=0"
#Add-Content $path "$iconfile"
#Add-Content $path "IconIndex=0"
}