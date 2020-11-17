
Install-Module -Name Az -AllowClobber

$ScriptPath = Split-Path $MyInvocation.InvocationName 
#$ScriptPath = $MyInvocation.InvocationName 
Write-Host  'EXECUTING: $ScriptPath ';
$ScriptPath += "\modules\JOB_StdFunctions.ps1"
Import-Module "$ScriptPath" ;
#Import-Module "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1" ;

$JobPath = Split-Path $MyInvocation.InvocationName 
$JobPath += "D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\" ;

clear;

function fillDS($connString, $qry){

    $QueryText = $qry;
 
    $SqlConnection = new-object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $connString
    $SqlCommand = $SqlConnection.CreateCommand()
    $SqlCommand.CommandText = "$QueryText"
 
    $DataAdapter = new-object System.Data.SqlClient.SqlDataAdapter $SqlCommand
    $dataset1 = new-object System.Data.Dataset
    $DataAdapter.Fill($dataset1);
    #$dataset1.Tables[0] | Export-CSV D:\Temp\ActiveServers.csv -Force
    return $dataset1.Tables[0];

}

function getActiveServers($connString){

    $QueryText = "SELECT [GroupName]
      ,[isAzure]
      ,[SvrName]
      ,[DBName]
      ,[UserID]
      ,[pwd]
      ,[UID]
  FROM [ActiveServers] order by GroupName, SvrName";
 
    $SqlConnection = new-object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $connString
    $SqlCommand = $SqlConnection.CreateCommand()
    $SqlCommand.CommandText = "$QueryText"
 
    $DataAdapter = new-object System.Data.SqlClient.SqlDataAdapter $SqlCommand
    $dataset1 = new-object System.Data.Dataset
    $DataAdapter.Fill($dataset1);
    #$dataset1.Tables[0] | Export-CSV D:\Temp\ActiveServers.csv -Force
    return $dataset1.Tables[0];

}
function getActiveJobs($connString){
    $QueryText = "SELECT * FROM [DFS_PowershellJobSchedule]";
    
    $SqlConnection = new-object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $connString
    $SqlCommand = $SqlConnection.CreateCommand()
    $SqlCommand.CommandText = "$QueryText"
 
    $DataAdapter = new-object System.Data.SqlClient.SqlDataAdapter $SqlCommand
    $dataset1 = new-object System.Data.Dataset
    $DataAdapter.Fill($dataset1);
    #$dataset1.Tables[0] | Export-CSV D:\Temp\ActiveServers.csv -Force
    return $dataset1.Tables[0];
    }

$connString = "Data Source=ALIEN15;Initial Catalog=DFINAnalytics;User Id=sa; Password=Junebug1;"
$i = 1 ;
$j = 1 ;

$QueryText = "SELECT [GroupName]
      ,[isAzure]
      ,[SvrName]
      ,[DBName]
      ,[UserID]
      ,[pwd]
      ,[UID]
  FROM [ActiveServers] order by GroupName, SvrName";

$activeServers = fillDS $connString $QueryText ;
 
$QueryText = "SELECT [Enabled]
      ,[FQN]
      ,[psJobName]
      ,[ScheduleUnit]
      ,[ScheduleExecValue]
      ,[StartTime]
      ,[LastRunTime]
      ,[NextRunTime]
      ,[UID]
      ,[RowNbr]
      ,ExecutionOrder
      ,RunIdReq
  FROM [dbo].[DFS_PowershellJobSchedule]
  where Enabled = 1
  order by ExecutionOrder" ;

$activeJobs = fillDS $connString $QueryText ;

 while  ($i -lt $activeServers.count)
{ 
    $item = $activeServers.Item($i);
    $GroupName = $item['GroupName'];
    $SvrName = $item['SvrName'];
    $DBName = $item['DBName'];
    $isAzure = $item['isAzure'];
    $UserID = $item['UserID'];  
    $pwd = $item['pwd'];  
    $UID = $item['UID'];  

    write-host "value is $item : $SvrName @ $DBName"
    $i += 1;
    $j = 1 ;
    while  ($j -lt $activeJobs.count)
    {        
        $obj = $activeJobs.Item($j);
        $FQN = $obj['FQN'];
        $psJobName = $obj['psJobName'];
        $ScheduleUnit = $obj['ScheduleUnit'];
        $ScheduleExecValue = $obj['ScheduleExecValue'];
        $StartTime = $obj['StartTime'];
        $LastRunTime = $obj['LastRunTime'];
        $NextRunTime = $obj['NextRunTime'];
        $UID = $obj['UID'];
        $ExecutionOrder = $obj['ExecutionOrder'];
        $RunIdReq = $obj['RunIdReq'];
        $RunNow = 0 ;

        $JobFqn = "$FQN$psJobName";
        $ElapsedX = 0 ; 
        $d1 = $LastRunTime;
        $d2 = Get-Date -DisplayHint Date
        $ts = New-TimeSpan -Start $d1 -End $d2
        
        if ($ScheduleUnit -eq 'minute'){
            $ElapsedX = $ts.Minutes # Check results
            if ($ElapsedX -ge $ScheduleExecValue){
                $RunNow = 1;
            }
        }
        if ($ScheduleUnit -eq 'hour'){
            $ElapsedX = $ts.Hours # Check results
            if ($ElapsedX -ge $ScheduleExecValue){
                $RunNow = 1;
            }
        }
        if ($ScheduleUnit -eq 'day'){
            $ElapsedX = $ts.Days # Check results
            if ($ElapsedX -ge $ScheduleExecValue){
                $RunNow = 1;
            }
        }
        if ($ScheduleUnit -eq 'month'){
            $ElapsedX = $ts.Days # Check results
            if ($ElapsedX -ge $ScheduleExecValue){
                $RunNow = 1;
            }
        }

        write-host "$JobFqn :: $ElapsedX :: $ScheduleUnit";
        if ($RunNow -eq 1){
            write-host "EXECUTING : $SvrName @ $DBName @ $psJobName @ $ScheduleUnit @ $ScheduleExecValue";

            if ($RunIdReq -eq 1){
                $RunID = getRunID;
            }

            if ($user) {
                $user = $user.trim();
            }

            if ($pwd) {
                $pwd = $pwd.trim();
            }
    
            try{
                if ($RunIdReq -eq 0){
                    $qry = "exec $psJobName ;" ;
                }
                if ($RunIdReq -eq 1){
                    $qry = "exec $psJobName $RunID ;" ;
                }
                if ($user){
                    $rc = Invoke-Sqlcmd -ServerInstance $SvrName -Database $DBName -Username $UserID -Password $pwd -Query $qry ;
                }
                else {
                    $rc = Invoke-Sqlcmd -ServerInstance $SvrName -Database $DBName -Query $qry ;
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
        }
        
        $j += 1;
    }
}

write-host "*********************************************";
write-host "DONE";
write-host "*********************************************";