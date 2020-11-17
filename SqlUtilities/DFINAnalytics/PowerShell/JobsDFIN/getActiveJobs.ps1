Install-Module -Name Az -AllowClobber

$ScriptPath = Split-Path $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\JobsDFIN\modules\JOB_StdFunctions.ps1"
Import-Module "$ScriptPath" ;

clear;   
$env:AzureRmContextAutoSave="true" ;
$JobName = $MyInvocation.MyCommand.Definition;
showRunning $JobName ;

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = “Server=Alien15;Integrated Security=true;Initial Catalog=master”

$Jobs = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_ActiveJobFetch" 

foreach ($Job in $Jobs)
{ 
    $JobName  = $($Job[0]);
    $JobDisabled = $($Job[1]);
    $StepName = $($Job[2]);
    $StepSQL = $($Job[3]);
    $StepDisabled = $($Job[4]);
    $RunIdReq = $($Job[5]);
    $RowNbr = $($Job[6]);
    write-host ("$JobName @ $JobDisabled @ $StepName @ $StepSQL @ $StepDisabled @ $RunIdReq @ $RowNbr");
}