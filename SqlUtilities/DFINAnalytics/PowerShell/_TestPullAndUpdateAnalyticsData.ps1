
$Instance = "dfin.database.windows.net,1433";
$db = "AW_Azure";
$user = 'wmiller';
$pwd = 'Junebug1';

$TBL = 'DFS_CPU_BoundQry2000';

Get-Command -Name *SQL*TableData

$Qry = "select top 100 * from $TBL"
$Qry

#Y|dfin.database.windows.net,1433 | AW_AZURE | wmiller | Junebug1
if ($user){
    #$rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -OutputAs DataTables -Query $QueryText |Write-SqlTableData -ServerInstance "Alien15" -DatabaseName DFINAnalytics -SchemaName dbo -TableName $TBL 
    $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry -OutputAs DataTables | Write-SqlTableData -ServerInstance "Alien15" -DatabaseName "DFINAnalytics" -SchemaName "dbo" -TableName "DFS_CPU_BoundQry2000-temp" -force
    #$rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Username $user -Password $pwd -Query $qry -QueryTimeout 120 ;
}
else {
    #$rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -Query $qry -QueryTimeout 120 ;
    $rc = Invoke-Sqlcmd -ServerInstance $Instance -Database $db -OutputAs DataTables -Query $QueryText |Write-SqlTableData -ServerInstance "Alien15" -DatabaseName DFINAnalytics -SchemaName dbo -TableName $TBL
}
$rc
