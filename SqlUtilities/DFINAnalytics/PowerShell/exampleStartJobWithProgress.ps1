


#$myjob = start-job -scriptblock {D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_UTIL_Monitor_TPS.ps1}

start-job -filepath {D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_UTIL_Monitor_TPS.ps1}
start-job -filepath {D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_DFS_MonitorLocks.ps1}
#start-job -filepath {D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_UTIL_TxMonitorTableStats.ps1}

# Get all the running jobs
$jobs = get-job | ? { $_.state -eq "running" }
$total = $jobs.count
$runningjobs = $jobs.count

# Loop while there are running jobs
while($runningjobs -gt 0) {
    # Update progress based on how many jobs are done yet.
    write-progress -activity "Events" -status "Progress:" `
   -percentcomplete (($total-$runningjobs)/$total*100)

    # After updating the progress bar, get current job count
    $runningjobs = (get-job | ? { $_.state -eq "running" }).Count
}