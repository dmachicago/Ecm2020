Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1 ;

$ScriptPath = Split-Path $MyInvocation.InvocationName ;

$date = Get-Date -format "yyyyMMdd"
$dt = Get-Date -Format g
$fqn = $ScriptPath + "\ERRORS\_Errors.txt";

$ErrFileName = $fqn;

recordError "INIT-INSTANCE" "INIT-DB" "RunAllJobs" "Initialize the error file" $fqn ;

#if (Test-Path $ErrFileName) 
#{
#  Remove-Item $ErrFileName
#}

$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path $ErrFileName -append
# Do some stuff

clear;
#$JobName = $MyInvocation.MyCommand.Definition
#showRunning($JobName)

& "$ScriptPath\JOB_DFS_BoundQry_ProcessAllTables.ps1"
& "$ScriptPath\JOB_UTIL_Monitor_TPS.ps1"
& "$ScriptPath\JOB_UTIL_ReorgFragmentedIndexes.ps1"
& "$ScriptPath\JOB_CaptureWorstPerfQuery.ps1"
#Start-Parallel "$ScriptPath\JOB_CaptureWorstPerfQuery.ps1"

& "$ScriptPath\JOB_DFS_CleanDFSTables.ps1"
& "$ScriptPath\JOB_DFS_GetAllTableSizesAndRowCnt.ps1"
& "$ScriptPath\JOB_DFS_MonitorLocks.ps1"
& "$ScriptPath\JOB_JOB_UTIL_MonitorDeadlocks.ps1"
& "$ScriptPath\JOB_MonitorWorkload.ps1"
& "$ScriptPath\JOB_UTIL_DbMon_IndexVolitity.ps1"
& "$ScriptPath\JOB_UTIL_DBSpace.ps1"
& "$ScriptPath\JOB_UTIL_DBTableSpace.ps1"
& "$ScriptPath\JOB_UTIL_DFS_DbSize.ps1"
& "$ScriptPath\JOB_UTIL_GetIndexStats.ps1"
& "$ScriptPath\JOB_UTIL_MonitorDeadlocks.ps1"
& "$ScriptPath\JOB_UTIL_MonitorMostCommonWaits.ps1"
& "$ScriptPath\JOB_UTIL_ParallelMonitor.ps1"

#& "$ScriptPath\JOB_UTIL_QryPlanStats.ps1"
Stop-Transcript | out-null
Start-Parallel "$ScriptPath\JOB_UTIL_QryPlanStats.ps1"

Start-Transcript -path $ErrFileName -append

& "$ScriptPath\JOB_UTIL_TempDbMonitor.ps1"
& "$ScriptPath\JOB_UTIL_TrackSessionWaitStats.ps1"

& "$ScriptPath\JOB_UTIL_TxMonitorTableStats.ps1"
#Start-Parallel "$ScriptPath\JOB_UTIL_TxMonitorTableStats.ps1"

Stop-Transcript | out-null

$ReviewErrors = 0 ;
if ($ReviewErrors -eq 1) {
    if (Test-Path $ErrFileName) {
      Start-Process notepad.exe $ErrFileName
    }
}
else {
    write-host "*****************************************"
    write-host "**** ERROR REVIEW OFF *******************"
    write-host "*****************************************"
}