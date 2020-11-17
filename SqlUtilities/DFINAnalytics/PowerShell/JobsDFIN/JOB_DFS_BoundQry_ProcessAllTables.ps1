#JOB_DFS_BoundQry_ProcessAllTables

Install-Module -Name Az -AllowClobber

$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"
Import-Module "$ScriptPath" ;
#Import-Module "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1" ;

clear

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
        if ($isAzure -ne "Y"){
            Write-Output "        EXEC : DFS_CPU_BoundQry2000_ProcessTable";
            $qry = "exec DFS_CPU_BoundQry2000_ProcessTable " ;
            if ($user){
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
            }

            Write-Output "        EXEC : DFS_CPU_BoundQry2000_ProcessTable";
            $qry = "exec DFS_IO_BoundQry2000_ProcessTable " ;
            if ($user){
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
            }

            Write-Output "        EXEC : UTIL_DFS_CPU_BoundQry";
            $qry = "exec UTIL_DFS_CPU_BoundQry " ;
            if ($user){
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
            }

            Write-Output "        EXEC : UTIL_IO_BoundQry";
            $qry = "exec UTIL_IO_BoundQry " ;
            if ($user){
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
            }
            Write-Output "        EXEC : sp_UTIL_MSTR_BoundQry2000";
            $qry = "exec sp_UTIL_MSTR_BoundQry2000 " ;
            if ($user){
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry ;
            }
            /*
            sp_UTIL_MSTR_BoundQry2000
            */
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