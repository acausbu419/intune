REM Create folders needed prior to copying items
if not exist "C:\ProgramData\AutoPilotConfig" md "C:\ProgramData\AutoPilotConfig"
if not exist "C:\ProgramData\AutoPilotConfig\Start Menu" md "C:\ProgramData\AutoPilotConfig\Start Menu"
if not exist "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs" md "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs"

REM Wipe launcher version file
del /f "%ALLUSERSPROFILE%\AutoPilotConfig\launcher_ver090"

REM Wipe out URL files prior to importing as new
del /f "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\*.url"

REM Placeholder to reset icons
REM del /f "%ALLUSERSPROFILE%\AutoPilotConfig\Icons\*.*

REM Copy over all ICO files
xcopy ".\Icons\GreenshadesIcon.ico" "%ALLUSERSPROFILE%\AutoPilotConfig\Icons\" /Y
xcopy ".\Icons\IODIcon.ico" "%ALLUSERSPROFILE%\AutoPilotConfig\Icons\" /Y
xcopy ".\Icons\KronosIcon.ico" "%ALLUSERSPROFILE%\AutoPilotConfig\Icons\" /Y
xcopy ".\Icons\MailIcon.ico" "%ALLUSERSPROFILE%\AutoPilotConfig\Icons\" /Y
xcopy ".\Icons\MSDSIcon.ico" "%ALLUSERSPROFILE%\AutoPilotConfig\Icons\" /Y
xcopy ".\Icons\SharePointIcon.ico" "%ALLUSERSPROFILE%\AutoPilotConfig\Icons\" /Y

REM Copy over all URL files
xcopy ".\Shortcuts\AR RX Monitoring.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\KY RX Monitoring.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\MS RX Monitoring.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Camera.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Careware.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Compliance Manager.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\DOT Exams.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Eligibility.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Freshdesk.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Greenshades.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Healthstream.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\IOD.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Knowledge Portal.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Kronos.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\LabCorpLink.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Mail.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\MSDS Search.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\Provider in Network.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y
xcopy ".\Shortcuts\ReqLogic.url" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /Y

REM Create Version Counter
echo complete > "%ALLUSERSPROFILE%\AutoPilotConfig\launcher_ver090"