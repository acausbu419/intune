if not exist "C:\ProgramData\AutoPilotConfig" md "C:\ProgramData\AutoPilotConfig"
xcopy "SnipeITScript.ps1" "C:\ProgramData\AutoPilotConfig" /Y
Powershell.exe -Executionpolicy bypass -File "C:\ProgramData\AutoPilotConfig\SnipeITScript.ps1"