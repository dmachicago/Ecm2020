$parms = "Y|dfin.database.windows.net,1433|TestAzureDB|wmiller|Junebug1";
#$isAzure, $Instance, $db, $user, $pwd 
#&"D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ UTIL_Monitor_TPS_Parms.ps1" $parms

Start-Parallel D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\JOB_ UTIL_Monitor_TPS_Parms.ps1