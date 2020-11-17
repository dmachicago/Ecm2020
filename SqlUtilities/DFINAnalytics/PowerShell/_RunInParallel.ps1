Install-Module -Name Start-parallel

Function QuickPing { 
    param ($LastByte) 
    $P = New-Object -TypeName "System.Net.NetworkInformation.Ping" 
    $P.Send("192.168.0.$LastByte") | where status -eq success | select address, roundTripTime 
}

#Start-Parallel D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_UTIL_QryPlanStats.ps1 -MaxThreads 200 
#Start-Parallel D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_JOB_UTIL_MonitorDeadlocks.ps1 -MaxThreads 200 

Start-Parallel –scriptblock ${Function:\QuickPing}  -MaxThreads 200 