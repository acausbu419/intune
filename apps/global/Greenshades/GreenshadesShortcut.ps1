if (-not (Test-Path "C:\Users\Public\Desktop\Greenshades.url"))
{
$null = $WshShell = New-Object -comObject WScript.Shell
$path = "C:\Users\Public\Desktop\Greenshades.url"
$targetpath = "https://www.greenshadesonline.com/SSO/EmployeeApp/#/company/ARCARE/login"
#$iconlocation = "C:\ProgramData\AutoPilotConfig\Icons\GreenshadesIcon.ico"
#$iconfile = "IconFile=" + $iconlocation
$Shortcut = $WshShell.CreateShortcut($path)
$Shortcut.TargetPath = $targetpath
$Shortcut.Save()

Add-Content $path "HotKey=0"
#Add-Content $path "$iconfile"
#Add-Content $path "IconIndex=0"
}