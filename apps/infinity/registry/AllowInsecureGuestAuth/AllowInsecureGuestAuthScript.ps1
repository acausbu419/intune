#This script allows non secure guest access to SMB shares.
#
#This script is only applicable to ICSRX and is not to be deployed without approval.

Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters' -Name AllowInsecureGuestAuth -Value 1 -Force