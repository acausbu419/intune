if not exist "C:\ProgramData\AutoPilotConfig" md "C:\ProgramData\AutoPilotConfig"
if not exist "C:\ProgramData\AutoPilotConfig\Icons" md "C:\ProgramData\AutoPilotConfig\Icons"
xcopy "IODShortCut.ps1" "C:\ProgramData\AutoPilotConfig" /Y
xcopy "IODIcon.ico" "C:\ProgramData\AutoPilotConfig\Icons" /Y
Powershell.exe -Executionpolicy bypass -File "C:\ProgramData\AutoPilotConfig\IODShortCut.ps1"