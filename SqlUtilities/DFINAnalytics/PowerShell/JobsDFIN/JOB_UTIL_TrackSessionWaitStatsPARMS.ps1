#JOB_UTIL_TrackSessionWaitStats
<#
declare @MaxWaitMS int = 30;
DECLARE @RunID INT= 0;
EXEC @RunID = DFINAnalytics.dbo.UTIL_GetSeq;
declare @stmt nvarchar(100) = 'use ?; exec sp_UTIL_DFS_WaitStats '+cast(@RunID as nvarchar(15))+', '+cast(@MaxWaitMS as nvarchar(15))+' ; '
exec sp_msForEachDB @stmt ;
#>


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
    $RunID = getRunID; 

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
        $qry = "exec sp_UTIL_DFS_WaitStats " + $RunID + "," + $MaxWaitMS;
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