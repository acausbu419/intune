#Disables startup items that do not appear in startup folder
#Currently only configured to disable Microsoft Teams

$regpath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run -Name "com.squirrel.Teams.Teams"'

Try {
    If(!(Test-Path $regpath -ErrorAction SilentlyContinue)){
        Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run -Name "com.squirrel.Teams.Teams" -Value ([byte[]](0x33,0x32,0xFF))    
    }
    Return $true
}
Catch {
    Return $false
}