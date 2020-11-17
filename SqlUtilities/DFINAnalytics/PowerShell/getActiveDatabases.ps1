Install-Module -Name Az -AllowClobber

$ScriptPath = Split-Path $MyInvocation.InvocationName 
Write-Host  "EXECUTING: $ScriptPath ";
#D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules
$ScriptPath += "\JobsDFIN\modules\JOB_StdFunctions.ps1"
Import-Module "$ScriptPath" ;

clear;   
$env:AzureRmContextAutoSave="true" ;
$JobName = $MyInvocation.MyCommand.Definition;
showRunning $JobName ;

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = “Server=Alien15;Integrated Security=true;Initial Catalog=master”

$ActiveServers = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_getActiveDatabases" 
$Jobs = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_ActiveJobFetch" 

foreach ($Server in $ActiveServers)
{ 
    $runid = getRunID;
    $svr = $($Server[0]);
    $db = $($Server[1]);
    $uid = $($Server[2]);
    $pw = $($Server[3]);
    write-host ("--------------------------------------------------------");
    write-host ("$svr @ $db @ $uid @ $pw");
    foreach ($Job in $Jobs)
    { 
        $JobName  = $($Job[0]);
        $JobDisabled = $($Job[1]);
        $StepName = $($Job[2]);
        $StepSQL = $($Job[3]);
        $StepDisabled = $($Job[4]);
        $RunIdReq = $($Job[5]);
        $RowNbr = $($Job[6]);
        $qry = '' ;
        if ($RunIdReq -eq 'N'){
            $qry = "EXEC $StepSQL";
        }
        else {
            $qry = "EXEC $StepSQL $runid";
        }
        write-host ("---------------------------------------------------------------------------------------------");
        write-host ("$JobName @ $JobDisabled @ $StepName @ $StepSQL @ $StepDisabled @ $RunIdReq @ $RowNbr @ $qry");

        if ($JobDisabled -eq 'N') {
            if ($StepDisabled -eq 'N'){
                write-host ("EXECUTING $JobName, STEP $StepName ON $svr IN db $DB");
                if ($user){
                    $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Username $uid -Password $pw -Query $qry ;
                }
                else {
                    $rc = Invoke-Sqlcmd -ServerInstance $svr -Database $db -Query $qry ;
                }
                write-host ("Completed... $JobName, STEP $StepName ON $svr IN db $DB");
            }
        }
        write-host ("---------------------------------------------------------------------------------------------");

    }
}