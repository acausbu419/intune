# Apps to be removed
$AppsList = "Microsoft.BingWeather",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.GetHelp",
"Microsoft.Getstarted",
"Microsoft.Microsoft3DViewer",
"Microsoft.OneConnect",
"Microsoft.SkypeApp",
"Microsoft.Wallet",
"Microsoft.WebMediaExtensions",
"Microsoft.WindowsCamera",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxApp",
"Microsoft.XboxGameOverlay",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay",
"Microsoft.Messaging",
"Microsoft.ZuneVideo",
"Microsoft.WindowsAlarms",
"Microsoft.ZuneMusic",
"Microsoft.StorePurchaseApp",
"Microsoft.Office.OneNote",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.People",
"Microsoft.BingNews",
"Microsoft.Office.Sway",
"Microsoft.OfficeLens",
"Microsoft.Todos",
"Microsoft.Whiteboard",
"Microsoft.WindowsFeedbackHub",
"Microsoft.WindowsMaps",
"Microsoft.WindowsSoundRecorder",
"Microsoft.Advertising.Xaml",
"Microsoft.RemoteDesktop",
"Microsoft.NetworkSpeedTest"

# Loop to remove apps
foreach ($App in $AppsList){
    $Packages = Get-AppxPackage | Where-Object {$_.Name -eq $App}
    if ($Packages -ne $null) {
        "Removing Appx Package: $App"
        foreach ($Package in $Packages) { Remove-AppxPackage -Package $Package.PackageFullName }
    else { "Unable to find package: $App" }

    $ProvisionedPackage = Get-AppxProvisionedPackage -online | Where-Object {$_.DisplayName -eq $App}
    if ($ProvisionedPackage -ne $null) {
        "Removing Appx Provisioned Package: $App"
        Remove-AppxProvisionedPackage -online -packagename $ProvisionedPackage.PackageName
        }
    else { "Unable to find provisioned package: $App" }
}}

# set time zone
set-timezone -name "Central Standard Time"

# turn off hibernation
powercfg -h off
powercfg -x -monitor-timeout-ac 15
powercfg -x -monitor-timeout-dc 15
powercfg -x -hibernate-timeout-ac 0
powercfg -x -hibernate-timeout-dc 0
powercfg -x -standby-timeout-ac 0
powercfg -x -standby-timeout-dc 0
powercfg -x -disk-timeout-ac 0
powercfg -x -disk-timeout-dc 0

# onedrive removal (64bit)
#taskkill /f /im onedrive.exe

#c:\windows\syswow64\onedrivesetup.exe /uninstall

if(!(Test-Path -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\')){
    New-Item -Path 'HKLM:\Software\COMPANYNAME' -ItemType key
    New-Item -Path 'HKLM:\Software\COMPANYNAME\AutoPilot' -ItemType key
    New-ItemProperty -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\' -Name WindowsCleanup -Value 1 -Force
}
else{New-ItemProperty -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\' -Name WindowsCleanup -Value 1 -Force}
