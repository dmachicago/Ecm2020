
function getSPText ($Server, $Database, $FqnProc) {
    [string] $SQLQuery= $("SELECT definition FROM sys.sql_modules  WHERE object_id = (OBJECT_ID(N'$FqnProc')); ");
    $sptext = '' ;
    $Connection = New-Object System.Data.SQLClient.SQLConnection
    $Connection.ConnectionString = "server='$Server';database='$Database';trusted_connection=true;"
    $Connection.Open()
    $Command = New-Object System.Data.SQLClient.SQLCommand
    $Command.Connection = $Connection
    $Command.CommandText = $SQLQuery
    $Reader = $Command.ExecuteReader()
    while ($Reader.Read()) {
         
         $sptext = $Reader.GetValue($1)
    }
    $Connection.Close()
    return $sptext;
}

[string] $Server= "ALIEN15";
[string] $Database = "DFINAnalytics";

$TgtProc = "UTIL_findLocks";
$FqnProc = "$Database.$TgtSchema.$TgtProc";

clear;
$spcode = getSPText $Server $Database $FqnProc ;
clear ;
$spcode;