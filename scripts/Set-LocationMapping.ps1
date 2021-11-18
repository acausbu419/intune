#Get-NetIPAddress -AddressFamily IPv4 | Where-Object ($_.IPAddress -Contains "10.110.")


try{
    #Grab HOSTNAME and IPV4 Address
    $ipv4Address = Get-NetIPAddress -AddressFamily IPv4 | Where-Object IPAddress -Like "10.110.*" | Select-Object IPAddress
    $hostname = $env:COMPUTERNAME

    if("[dlv][efopt]-\d\d\d-\d\d\d\d\d\d" -notmatch $hostname){
        throw "Invalid Hostname"
    }

$temp = $ipv4Address.IPAddress.Split(".")
$ipv4_location = $temp[2]

$temp = $hostname.Split("-")
$device_location = $temp[1]



while($ipv4_location.Length -ne 3){
    $ipv4_location = "0" + $ipv4_location
}

$device_location
$ipv4_location

if($ipv4_location -eq $device_location){
    #hostname and ipv4_location match
    [System.Environment]::SetEnvironmentVariable('FA',$ipv4_location,'User')
    Write-EventLog -LogName AutoPilotConfig -Source "SetLocationMapping" -EventId 0 -EntryType Information -Message "Location updated to $device_location."
}

}
catch {
    #IF a valid IP isn't found
    if($null -eq $ipv4Address){
        Write-EventLog -LogName "Application" -Source "AutoPilotConfig" -EventId 3000 -EntryType Error -Message "Invalid IP address: $hostname. Location variable will not be set." -Category 1
    }
    #IF a valid HOSTNAME isn't found
    elseif($error[0] -like "*Invalid Hostname*"){
        Write-EventLog -LogName AutoPilotConfig -Source "SetLocationMapping" -EventId 3001 -EntryType Error -Message "Invalid hostname: $hostname. Location variable will not be set."
    }
}