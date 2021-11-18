#Removes duplicate shortcuts following a pattern like 'Microsoft Edge (2)' or 'Microsoft Edge - Copy'
#Currently only set to follow these patterns for Microsoft Edge and Teams

function Remove-StartupItems{
    Param([String]$folder = [Environment]::GetFolderPath("Desktop"))
    Try {
        #Find partial matches during initial setup to attempt 
        #to clear up some generated duplicates
        #Possibly better served as a repeating check in the future

        #Targeted shortcut list
        if (!(Test-Path -Path "$($folder)\Microsoft Teams (*.lnk")`
            -and`
            !(Test-Path -Path "$($folder)\Microsoft Teams - Copy*.lnk")`
            -and`
            !(Test-Path -Path "$($folder)\Microsoft Edge (*.lnk")`
            -and`
            !(Test-Path -Path "$($folder)\Microsoft Edge - Copy*.lnk")){
                #Successful at finding no matches
                Return $true
            }
        else{
            #If a shortcut is found, remove any targeted match
            remove-item -path $folder\* -filter "Microsoft Teams (*.lnk"
            remove-item -path $folder\* -filter "Microsoft Teams - Copy*.lnk"
            remove-item -path $folder\* -filter "Microsoft Edge (*.lnk"
            remove-item -path $folder\* -filter "Microsoft Edge - Copy*.lnk"
            #Throw an exception for a subsequent pass
            throw "Error: Some files were present on first pass."
        }
    }
    Finally {
            #When an exception is caught, clear the error var and double check
            if($error[0] -match "Error: Some files were present on first pass."){
            $error.Clear()
            Remove-StartupItems
        }
    }
}

#Runs the function
Remove-StartupItems