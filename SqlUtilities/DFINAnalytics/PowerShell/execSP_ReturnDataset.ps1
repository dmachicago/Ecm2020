clear ;

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

        write-host "value is $obj : psJobName @ $ScheduleUnit @ $ScheduleExecValue"
    }
}


$activeServers = getActiveServers $connString ; 
$activeJobs = getActiveJobs $connString ; 

Write-Host $activeServers;
Write-Host $activeJobs;

Write-Host $activeServers.count;
Write-Host $activeJobs.count;
Write-Host 'records successfully pulled'

$activeJobs.Tables[0] | foreach {
    write-host 'FQN value is : $_.FQN;
    write-host 'psJobName value is : $_.psJobName;
}

foreach ($Row in $activeJobs.Tables[0].Rows)
{ 
    write-host "$($Row[0])"
    write-host "value is $Row : $Row.FQN @ $Row.psJobName"
}
