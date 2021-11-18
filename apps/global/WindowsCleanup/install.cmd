if not exist "C:\ProgramData\AutoPilotConfig" md "C:\ProgramData\AutoPilotConfig"
xcopy "WindowsCleanupScript.ps1" "C:\ProgramData\AutoPilotConfig" /Y
Powershell.exe -Executionpolicy bypass -File "C:\ProgramData\AutoPilotConfig\WindowsCleanupScript.ps1"