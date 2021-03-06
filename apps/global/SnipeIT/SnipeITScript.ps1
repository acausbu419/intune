#region Prereqs
#Modules required script to function
if (Get-Module -ListAvailable -Name SnipeitPS) {
    Set-ExecutionPolicy Bypass -Force
    Import-Module SnipeitPS
}
else {
    Set-PackageSource -Name MyNuget -NewName NewNuGet -Trusted -ProviderName NuGet -Force -ErrorAction SilentlyContinue
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted -ErrorAction SilentlyContinue
    Install-Module SnipeitPS -allowclobber
    Import-Module SnipeitPS
}

#Check for AutoPilotConfig setup folder
if(!(Test-Path "C:\ProgramData\AutoPilotConfig")){
    New-Item -Path "C:\ProgramData" -Name AutoPilotConfig -Type "directory"
}

#Check for results file (file that emails results of script)
if(!(Test-Path "C:\ProgramData\AutoPilotConfig\results.txt")){
    New-Item -Path "C:\ProgramData\AutoPilotConfig" -Name results.txt -Type "file"
}
else {
    Clear-Content -Path "C:\ProgramData\AutoPilotConfig\results.txt"
}
#endregion

#region assetcheck
#set snipeit url and api key
Set-Info -URL 'https://web-snipeit.COMPANYNAME.net' -apiKey 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYxZGZkOTUwNmM5YzBhNGI3ZmVmN2U3MTIzMGIxYWE3ZTE4NjUyY2YyZTZmZDFiMGZkZDZkNWE2ZmUxZGNhNGY1YjZlNDJmMGU2OTVmNmI3In0.eyJhdWQiOiIxIiwianRpIjoiZjFkZmQ5NTA2YzljMGE0YjdmZWY3ZTcxMjMwYjFhYTdlMTg2NTJjZjJlNmZkMWIwZmRkNmQ1YTZmZTFkY2E0ZjViNmU0MmYwZTY5NWY2YjciLCJpYXQiOjE2MTE2NzUyNTksIm5iZiI6MTYxMTY3NTI1OSwiZXhwIjoxNjQzMjExMjU5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Nr5cDh1nAwBuMteh04MRODUCj3Ch0aybnT-HIOldhwLG_W1WkWjZEsN-iyQVtuzjlR1DjgO5DrVGePeWBQmFxrjy8k5poou2Izh905uvUqAIqztcD_MFQK76ITNjSa1ahW63Lt-CjCffJK50RpySRJgsqYhodzyqbdjwR03HY-fIKr_7ZaOA-qRPWEZFZEuH5w4jdYFPGzro3Dlqzj47pUk1Mbcis7dLvx38ppCvBYxPZ08-yMXpKZiGfKPiIZR9fLwMBTZKA5QrRmWHApIeSvtZZTMx4pvKgI9o29-ys610qtVHiZd9hUBDZBJRb1V_PcHPPA8nchUob3dI9R48zzNo0kU4IcPjboAUF0l7hxxxcyPoNEuE6uGvy4EIoXZTcxwS58fsskYVW7VbAFog9O1Fd6zbPU73Rhjd5rDjli9SkYOUORXk6DTdUYjYIKEQhFslay_WfEse-1rLshm0k8Nqo6d7hmikTlO75oOj-vI1TquydzQ3K5Wnfc9pZ2DsuM1CDyQRWZWhrgBu0NS9akm4J9V39235JB5ep_My5RHcViYLxYdj6IZF38QMIbTm7ydvMG1AMpwikWo61BIAcC31devz-DoenCPVKyYENUPFoylgDfud0tQSJLChElV1aTZmpNm_fGSHid-BLEj78ZQaIOFo5Nklux2v-2m7GS0'
#grab asset tag from hostname
$hosttrunc = $env:COMPUTERNAME.Substring($env:COMPUTERNAME.Length -6,6)
#make sure the asset tag is valid
if($hosttrunc -notmatch "^\d+$"){
    $mailParams = @{
        SmtpServer                 = 'COMPANYNAME.mail.protection.outlook.com'
        Port                       = '25'
        UseSSL                     = $true   
        From                       = 'no_reply@COMPANYNAME.net'
        To                         = 'devicemanagement@COMPANYNAME.onmicrosoft.com'
        Subject                    = "Device Setup Results"
        Body                       = (Get-Content -Path "C:\ProgramData\AutoPilotConfig\results.txt") -join "`n"
        DeliveryNotificationOption = 'OnFailure', 'OnSuccess'
    }
    ## Send the email
    Send-MailMessage @mailParams
    #endregion
}
#check if asset tag exists in snipeit
$snipeit_check = Get-Asset -search $hosttrunc
#get device model
$hardware_info = Get-WmiObject -Class:Win32_ComputerSystem -Property PCSystemType,Manufacturer,Model

$snipeit_manufacturer = Get-Manufacturer -search $hardware_info.Manufacturer
$snipeit_model = Get-Model -search $hardware_info.Model

if($hardware_info.PCSystemType -eq 1){$snipeit_category = "2"}
elseif($hardware_info.PCSystemType -eq 2){$snipeit_category = "8"}

#end script if asset exists (no changes applied)
if($snipeit_check -ne $null){
    if(!(Test-Path -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\')){
        New-Item -Path 'HKLM:\Software\COMPANYNAME' -ItemType key
        New-Item -Path 'HKLM:\Software\COMPANYNAME\AutoPilot' -ItemType key
        New-ItemProperty -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\' -Name SnipeIT2021 -Value 1 -Force
    }
    else{New-ItemProperty -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\' -Name SnipeIT2021 -Value 1 -Force}
    Exit
}
else{
    #Unknown Manufacturer
    if($hardware_info.Manufacturer -ne $snipeit_manufacturer.name){
        New-Manufacturer -Name $hardware_info.Manufacturer
        $snipeit_manufacturer = Get-Manufacturer -search $hardware_info.Manufacturer
        Add-Content -Path "C:\ProgramData\AutoPilotConfig\results.txt" "New manufacturer, $($hardware_info.Manufacturer) created.`n`n"
    }
    #Unknown Model
    if($hardware_info.Model -ne $snipeit_model.name){
        New-Model -name $hardware_info.Model -category_id $snipeit_category -manufacturer_id $snipeit_manufacturer.id -fieldset_id "0"
        $snipeit_model = Get-Model -search $hardware_info.Model
        Add-Content -Path "C:\ProgramData\AutoPilotConfig\results.txt" "New model, $($hardware_info.Model) created.`n`n"
    }
    New-Asset -Name $env:COMPUTERNAME -tag $hosttrunc -Status_id 2 -Model_id $snipeit_model.id
    $snipeit_check = Get-Asset -search $hosttrunc
    Add-Content -Path "C:\ProgramData\AutoPilotConfig\results.txt" "New asset created:`n
                                                                    Hostname: $($env:COMPUTERNAME)
                                                                    Asset: $($hosttrunc)
                                                                    Device Model: $($hardware_info.Model)
                                                                    Device Manufacturer: $($hardware_info.Manufacturer)`n
                                                                    To complete any additional steps you can access the device page here:`n
                                                                    https://web-snipeit.COMPANYNAME.net/hardware/$($snipeit_check.id)"
    if(!(Test-Path -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\')){
        New-Item -Path 'HKLM:\Software\COMPANYNAME' -ItemType key
        New-Item -Path 'HKLM:\Software\COMPANYNAME\AutoPilot' -ItemType key
        New-ItemProperty -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\' -Name SnipeIT -Value 1 -Force
    }
    else{New-ItemProperty -Path 'HKLM:\Software\COMPANYNAME\AutoPilot\' -Name SnipeIT -Value 1 -Force}

    $mailParams = @{
        SmtpServer                 = 'COMPANYNAME.mail.protection.outlook.com'
        Port                       = '25'
        UseSSL                     = $true   
        From                       = 'no_reply@COMPANYNAME.net'
        To                         = 'devicemanagement@COMPANYNAME.onmicrosoft.com'
        Subject                    = "Device Setup Results"
        Body                       = (Get-Content -Path "C:\ProgramData\AutoPilotConfig\results.txt") -join "`n"
        DeliveryNotificationOption = 'OnFailure', 'OnSuccess'
    }
    ## Send the email
    Send-MailMessage @mailParams
    #endregion
}