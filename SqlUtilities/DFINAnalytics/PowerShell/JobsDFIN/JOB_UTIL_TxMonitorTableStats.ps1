#JOB_UTIL_TxMonitorTableStats
<#
        DECLARE @RunID BIGINT;
        EXEC @RunID = DFINAnalytics.dbo.UTIL_GetSeq;
        DECLARE @command VARCHAR(1000);
        SELECT @command = 'USE ?; exec sp_UTIL_TxMonitorIDX '+cast(@RunID as nvarchar(50))+' ; exec sp_UTIL_TxMonitorTableStats ' + CAST(@RunID AS NVARCHAR(25)) + ';' ;
        EXEC sp_MSforeachdb 
             @command;
#>


Install-Module -Name Az -AllowClobber
clear
#Connect-AzAccount
#add-AzureAccount


$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"
Import-Module $ScriptPath ;
#Import-Module "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1" ;

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
    $MaxWaitMS = 25;

    $rc = 0;
    $RunID = GetRunID;
    
    if ($user) {
        $user = $user.trim();
    }

    if ($pwd) {
        $pwd = $pwd.trim();
    }
    
    $stopwatch =  [system.diagnostics.stopwatch]::StartNew();
    Write-Output "PROCESSING: $Instance, $db";
    try{
        $qry = "" ;
        $qry = "exec sp_UTIL_TxMonitorIDX " + $RunID ;
        if ($user){
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry -QueryTimeout 120 ;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry -QueryTimeout 120 ;
        }

        $qry = "exec sp_UTIL_TxMonitorTableStats " + $RunID ;
        if ($user){
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry -QueryTimeout 120 ;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry -QueryTimeout 120 ;
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