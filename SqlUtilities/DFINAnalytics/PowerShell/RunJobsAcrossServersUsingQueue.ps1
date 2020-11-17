$servers = @('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n')

foreach ($server in $servers) {
    $running = @(Get-Job | Where-Object { $_.State -eq 'Running' })
    if ($running.Count -ge 4) {
        $running | Wait-Job -Any | Out-Null
    }

    Write-Host "Starting job for $server"
    Start-Job {
        # do something with $using:server. Just sleeping for this example.
        Start-Sleep 5
        return "result from $using:server"
    } | Out-Null
}

# Wait for all jobs to complete and results ready to be received
Wait-Job * | Out-Null

# Process the results
foreach($job in Get-Job)
{
    $result = Receive-Job $job
    Write-Host $result
}

Remove-Job -State Completed