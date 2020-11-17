param ([string]$svr,[string]$db,[string]$uid,[string]$pwd,[string]$isAzure, [string]$ScriptPath, [string] $qry, [string] $JobName, [string] $ReqRunID)
#JOB_DFS_BoundQry_ProcessAllTables

$CurrentJob = $JobName;

$global:MstrSvr = 'ALIEN15';
$global:MstrDB = 'DFINAnalytics';
$global:MstrUID = 'sa';
$global:MstrPW = 'Junebug1';

$QRY = "exec " + $QRY ;

#write-host "PASSED IN: < $svr , $db, $uid, $pwd, $isAzure, $ScriptPath, $JobName, $JobRowNbr, $StepRowNbr, $ReqRunID > ";
#write-host $qry
$d = date ;

Install-Module -Name Az -AllowClobber

#$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"

$ScriptPath 

Import-Module "$ScriptPath" ;
#Import-Module "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1" ;

Add-Content "D:\temp\_LOG_JobSteps.txt" "$d ------------------------- JOB_ExecuteJobStepPARMS ----------------------------------------------";
Add-Content "D:\temp\_LOG_JobSteps.txt" "$d STARTED Execution of job: $CurrentJob, JobRowNbr: $JobRowNbr, StepRowNbr: $StepRowNbr";
Add-Content "D:\temp\_LOG_JobSteps.txt" "$d PASSED IN: $svr, $db, $uid, $pwd, $isAzure, $ScriptPath, $CurrentJob, $JobRowNbr, $StepRowNbr";
Add-Content "D:\temp\_LOG_JobSteps.txt" "$d GLOBALS: $Global:MstrSvr, $Global:MstrDB, $Global:MstrUID, $Global:MstrPW.";
Add-Content "D:\temp\_LOG_JobSteps.txt" "$d $qry";


$env:AzureRmContextAutoSave="true" 

showRunning($CurrentJob);


    $results = '';
    $RunID = 0 ;
    $rc = 0;

    $RunID = getRunID;

    if (!$svr){
        return -10 ;
    }
    if (!$db){
        return -20 ;
    }

    if ($uid) {
        $uid = $uid.trim();
    }

    if ($pwd) {
        $pwd = $pwd.trim();
    }

    if ($ReqRunID -eq 'N'){
        if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'Y'){
            $qry = "EXEC $StepSQL";
            $RunProc = 1 ;
        }
        if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'N'){
            write-host "The server $svr is Azure the JobName: $CurrentJob and Step $StepName IS NOT Azure Compatible. "  -ForegroundColor Red;;
            $RunProc = 0 ;
            write-host ("") -ForegroundColor White;
        }
        if ($isAzureDB -eq 'N'){
            $qry = "EXEC $StepSQL";
            $RunProc = 1 ;
        }
    }
    else {
        if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'Y'){
            $qry = "EXEC $StepSQL $runid";
            $RunProc = 1 ;
        }
        if ($isAzureDB -eq 'Y' -and $AzureCompatibleSP -eq 'N'){
            write-host "The server $svr is Azure the JobName: $CurrentJob and Step $StepName IS NOT Azure Compatible. "  -ForegroundColor Red;;
            $RunProc = 0 ;
            write-host ("") -ForegroundColor White;
        }
        if ($isAzureDB -eq 'N'){
            $qry = "EXEC $StepSQL $runid";
            $RunProc = 1 ;
        }

    }

    $stopwatch =  [system.diagnostics.stopwatch]::StartNew();
    
    Write-Output "PROCESSING: $svr, $db";
    Add-Content "D:\temp\_LOG_JobSteps.txt" "$d PROCESSING: $svr, $db";

    try{
        #$qry = "" ;
        if ($RunProc = 1){
            
            #$qry = "exec DFS_CPU_BoundQry2000_ProcessTable " ;
            Write-Output "EXECUTING: $qry";

            if ($uid){
                setTimer "S" $CurrentJob $StepName $svr $tgtdb $DB_UID;
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $uid -Password $pwd -Query $qry ;
                setTimer "E" $CurrentJob $StepName $svr $tgtdb $DB_UID;
                setLastRunDate $svr $CurrentJob;
                Add-Content "D:\temp\_LOG_JobSteps.txt" "$d @1 SetTimer, Executed DB: $db,  job: $CurrentJob ";
            }
            else {
                setTimer "S" $CurrentJob $StepName $svr $tgtdb $DB_UID ;
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
                setTimer "E" $CurrentJob $StepName $svr $tgtdb $DB_UID ;
                setLastRunDate $svr $CurrentJob;
                Add-Content "D:\temp\_LOG_JobSteps.txt" "$d @1 SetTimer, Executed DB: $db,  job: $CurrentJob";
            }                                             
        }

        Write-Output "PROCESSED : $svr, $db";
        $d = date ;
        Add-Content "D:\temp\_LOG_JobSteps.txt" "$d @3 COMPLETED Execution of job: $CurrentJob, JobRowNbr: $JobRowNbr, StepRowNbr: $StepRowNbr";
    }
    catch {
            $ErrorMessage = $_.Exception.Message;
            $FailedItem = $_;
            
            $ErrPath = Split-Path $MyInvocation.InvocationName 
            $ErrPath += "\ERRORS\"
            recordError $svr $db $CurrentJob $ErrorMessage $ErrPath;
            recordError $svr $db $CurrentJob $FailedItem $ErrPath;

            Write-Output "ErrorMessage: $ErrorMessage";
            Write-Output "FailedItem: $FailedItem";
                 
            Add-Content "D:\temp\_LOG_JobSteps.txt" "@341 ErrorMessage: $ErrorMessage";
            Add-Content "D:\temp\_LOG_JobSteps.txt" "@342 FailedItem: $FailedItem";
                        
            #Echo the current object
            $_
    }
    recordStopwatch $CurrentJob $svr $db $stopwatch;

Write-Output "*************";
Write-Output "--->DONE <---";
Write-Output "*************";