#UTIL_TempDbMonitor

Install-Module -Name Az -AllowClobber
Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1 ;
clear

$env:AzureRmContextAutoSave="true" 

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

        }

        Write-Output "PROCESSED : $Instance, $db";
    }
    catch {
            $ErrorMessage = $_.Exception.Message;
            $FailedItem = $_;
            Write-Output "ErrorMessage: $ErrorMessage";
            Write-Output "FailedItem: $FailedItem";
            #Echo the current object
            $_
    }
}
Write-Output "*************";
Write-Output "--->DONE <---";
Write-Output "*************";