param ([string] $MstrSvr, [string] $MstrDB, [string] $MstrUID, [string]$MstrPW, [string]$svr, [string]$db, [string]$uid, [string]$pwd, [string]$qry)
write-host "PASSED IN: $svr, $db, $uid, $pwd, $isAzure, $ScriptPath"

Install-Module -Name Az -AllowClobber

#$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"

#Import-Module "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1" ;

clear
$ScriptPath 

$env:AzureRmContextAutoSave="true" 
$JobName = $MyInvocation.MyCommand.Definition
showRunning($JobName)


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
    $stopwatch =  [system.diagnostics.stopwatch]::StartNew();
    Write-Output "PROCESSING: $svr.$db @ $qry ";
    try{
        $qry = "" ;
        if ($isAzure -ne "Y"){
            
            $qry = "exec DFS_CPU_BoundQry2000_ProcessTable " ;
            Write-Output "$qry";

            if ($uid){
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $uid -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
            }

            $qry = "exec DFS_IO_BoundQry2000_ProcessTable " ;
            Write-Output "$qry";

            if ($uid){
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $uid -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
            }

            $qry = "exec UTIL_DFS_CPU_BoundQry " ;
            Write-Output "$qry";

            if ($uid){
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $uid -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
            }

            $qry = "exec UTIL_IO_BoundQry " ;
            Write-Output "$qry";

            if ($uid){
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $uid -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
            }
            
            $qry = "exec sp_UTIL_MSTR_BoundQry2000 " ;
            Write-Output "$qry";

            if ($uid){
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $uid -Password $pwd -Query $qry ;
            }
            else {
                $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
            }            
        }

        Write-Output "PROCESSED : $svr, $db";
    }
    catch {
            $ErrorMessage = $_.Exception.Message;
            $FailedItem = $_;
            
            $ErrPath = Split-Path $MyInvocation.InvocationName 
            $ErrPath += "\ERRORS\"
            recordError $svr $db $JobName $ErrorMessage $ErrPath;
            recordError $svr $db $JobName $FailedItem $ErrPath;

            Write-Output "ErrorMessage: $ErrorMessage";
            Write-Output "FailedItem: $FailedItem";
            #Echo the current object
            $_
    }
    recordStopwatch $JobName $svr $db $stopwatch;

Write-Output "*************";
Write-Output "--->DONE <---";
Write-Output "*************";