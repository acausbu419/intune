#This script requires elevations
#Used to create logs for separate scripts / processes to be used for troubleshooting.

$logs_source = "AutoPilotConfig"

try {
    ForEach($ls in $logs_source){
        New-EventLog -Source $ls -LogName Application -ErrorAction Stop
    }
}
catch{
    if($error[0] -like "*source is already registered*"){
        Write-Host "All sources added."
    }
}