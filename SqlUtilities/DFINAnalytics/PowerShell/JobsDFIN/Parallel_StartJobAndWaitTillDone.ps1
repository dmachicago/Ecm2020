ForEach ($Computer in $Computers){
    # Check to see if there are too many open threads
    # If there are too many threads then wait here until some close
    While ($(Get-Job -state running).count -ge $MaxThreads){
        Write-Progress  -Activity "Creating Server List" 
                        -Status "Waiting for threads to close" 
                        -CurrentOperation "$i threads created - $($(Get-Job -state running).count) threads open" 
                        -PercentComplete ($i / $Computers.count * 100)
        Start-Sleep -Milliseconds $SleepTimer
    }
 
    #"Starting job - $Computer"
    $i++
    Start-Job -FilePath $ScriptFile -ArgumentList $Computer -Name $Computer | Out-Null
    Write-Progress  -Activity "Creating Server List" 
                -Status "Starting Threads" 
                -CurrentOperation "$i threads created - $($(Get-Job -state running).count) threads open" 
                -PercentComplete ($i / $Computers.count * 100)
    
}