#JOB_DFS_MonitorLocks
<#
        DECLARE @RunID BIGINT;
        EXEC @RunID = DFINAnalytics.dbo.UTIL_GetSeq;
        PRINT @RunID;
        DECLARE @command VARCHAR(1000);
        SELECT @command = 'USE ?; declare @DB as int = DB_ID() ; exec sp_DFS_MonitorLocks ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
        EXEC sp_MSforeachdb @command;
#>

#JOB_DFS_GetAllTableSizesAndRowCnt


Install-Module -Name Az -AllowClobber

$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"
Import-Module "$ScriptPath" ;
#Import-Module "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1" ;

clear
#Connect-AzAccount
#add-AzureAccount

<#
DECLARE @command VARCHAR(1000);
SELECT @command = 'USE ?; exec sp_UTIL_ReorgFragmentedIndexes 0;';
EXEC sp_MSforeachdb @command;
#>

clear;   
$env:AzureRmContextAutoSave="true" 
$JobName = $MyInvocation.MyCommand.Definition
showRunning($JobName)


foreach ($RegisteredServer in Get-Content D:\dev\SQL\DFINAnalytics\ControlFiles\AllInstances.txt)
{
    
    $results = '';
    $isAzure, $Instance, $db, $user, $pwd = $RegisteredServer.split('|');
    $Instance = $Instance.trim();
    $db = $db.trim();
    $RunID = 0 ;

    $rc = 0;
    $RunID = getRunID;

    if ($user) {
        $user = $user.trim();
    }

    if ($pwd) {
        $pwd = $pwd.trim();
    }
    $stopwatch =  [system.diagnostics.stopwatch]::StartNew();
    Write-Output "PROCESSING: $Instance, $db";
    $DaysToKeep = 2 ;
    try{
        $qry = "" ;
        $qry = "exec sp_DFS_MonitorLocks ;" ;
        if ($user){
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
        }

        Write-Output "PROCESSED : $Instance, $db";
    }
    catch {
            $ErrorMessage = $_.Exception.Message;
            $FailedItem = $_;
            
            $ErrPath = Split-Path $MyInvocation.InvocationName 
            $ErrPath += "\ERRORS\"
            recordError $Instance $db $JobName $ErrorMessage $ErrPath;
            recordError $Instance $db $JobName $FailedItem $ErrPath;

            Write-Output "ErrorMessage: $ErrorMessage";
            Write-Output "FailedItem: $FailedItem";
            #Echo the current object
            $_
    }
    recordStopwatch $JobName $Instance $db $stopwatch;
}
Write-Output "*************";
Write-Output "--->DONE <---";
Write-Output "*************";