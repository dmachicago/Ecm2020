#JOB_UTIL_QryPlanStats
<#
exec UTIL_QryPlanStats
#>

Install-Module -Name Az -AllowClobber
Install-Module -Name Start-parallel

$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"
Import-Module "$ScriptPath" ;
#Import-Module "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1" ;

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
        $qry = "exec UTIL_QryPlanStats ;"
        if ($user){
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry -QueryTimeout 0 ;
        }
        else {
            $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry -QueryTimeout 0 ;
        }

        Write-Output "PROCESSED : $Instance, $db";
    }
    catch {
            $ErrorMessage = $_.Exception.Message;
            $FailedItem = $_;

            $ErrPath = Split-Path $MyInvocation.InvocationName 
            $ErrPath += "\ERRORS\"
            recordError $Instance $db $JobName $ErrorMessage $ScriptPath + "\Errors\" ;
            recordError $Instance $db $JobName $FailedItem $ScriptPath + "\Errors\" ;
            recordError $Instance $db $JobName $_ $ScriptPath + "\Errors\" ;

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