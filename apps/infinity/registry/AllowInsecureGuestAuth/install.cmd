if not exist "C:\ProgramData\AutoPilotConfig" md "C:\ProgramData\AutoPilotConfig"
xcopy "AllowInsecureGuestAuthScript.ps1" "C:\ProgramData\AutoPilotConfig" /Y
Powershell.exe -Executionpolicy bypass -File "C:\ProgramData\AutoPilotConfig\AllowInsecureGuestAuthScript.ps1"