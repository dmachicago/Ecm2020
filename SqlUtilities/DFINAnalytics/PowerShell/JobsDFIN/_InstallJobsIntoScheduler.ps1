Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1 ;

function taskExists ($TaskName){
    $taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }
    return $taskExists
}

function unregisterJob ($JobName){
    #Get-ScheduledJob | Unregister-ScheduledJob -Force
    Unregister-ScheduledJob -Name $JobName -Force
}

function registerJob ($PathName, $JobName, $RepIntervalUnit, $RepIntervalue, $StartDateTime){
    $fqn = $PathName+$JobName + ".ps1";
    $taskExists = taskExists ($JobName) ;
    if (! $taskExists){
        if ($RepIntervalUnit -eq 'minutes'){
            Register-ScheduledJob -Name $JobName -FilePath $fqn -Trigger (New-JobTrigger -Once -At $StartDateTime -RepetitionInterval (New-TimeSpan -Minutes $RepIntervalue) -RepetitionDuration ([TimeSpan]::MaxValue))
        }
        if ($RepIntervalUnit -eq 'hours'){
            Register-ScheduledJob -Name $JobName -FilePath $fqn -Trigger (New-JobTrigger -Once -At $StartDateTime -RepetitionInterval (New-TimeSpan -Hours $RepIntervalue) -RepetitionDuration ([TimeSpan]::MaxValue))
        }
        if ($RepIntervalUnit -eq 'days'){
            Register-ScheduledJob -Name $JobName -FilePath $fqn -Trigger (New-JobTrigger -Once -At $StartDateTime -RepetitionInterval (New-TimeSpan -Days $RepIntervalue) -RepetitionDuration ([TimeSpan]::MaxValue))
        }
        if ($RepIntervalUnit -eq 'months'){
            Register-ScheduledJob -Name $JobName -FilePath $fqn -Trigger (New-JobTrigger -Once -At $StartDateTime -RepetitionInterval (New-TimeSpan -Months $RepIntervalue) -RepetitionDuration ([TimeSpan]::MaxValue))
        }
    }
    else {
        Write-Host ("JOB '$JobName' already exists on machine, skipping install...");
    }
}

$StartDateTime = "9/28/2018 7:21pm";
$fPath = "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\";
#unregisterJob ("JOB_UTIL_TempDbMonitor");

unregisterJob ("JOB_ UTIL_ReorgFragmentedIndexes");
registerJob $fPath "JOB_ UTIL_ReorgFragmentedIndexes" "days" 7 $StartDateTime;


registerJob $fPath "JOB_UTIL_TempDbMonitor" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_UTIL_ParallelMonitor" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_ UTIL_Monitor_TPS" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_CaptureWorstPerfQuery" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_DFS_CleanDFSTables" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_DFS_GetAllTableSizesAndRowCnt" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_DFS_MonitorLocks" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_MonitorWorkload" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_StdFunctions" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_UTIL_DbMon_IndexVolitity" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_UTIL_DBSpace" "days" 1 $StartDateTime ;
registerJob $fPath "JOB_UTIL_DBTableSpace" "days" 1 $StartDateTime ;
registerJob $fPath "JOB_UTIL_DFS_DbSize" "days" 1 $StartDateTime ;
registerJob $fPath "JOB_UTIL_GetIndexStats" "days" 1 $StartDateTime ;
registerJob $fPath "JOB_UTIL_MonitorDeadlocks" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_UTIL_MonitorMostCommonWaits" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_UTIL_QryPlanStats" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_UTIL_TrackSessionWaitStats" "minutes" 10 $StartDateTime ;
registerJob $fPath "JOB_UTIL_TxMonitorTableStats" "minutes" 10 $StartDateTime ;