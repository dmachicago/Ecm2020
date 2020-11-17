
foreach ($RegisteredServer in Get-Content D:\temp\AllInstances.txt)
{

    $Instance, $db, $user, $pwd = $RegisteredServer.split('|');

    $Instance, $db, $user, $pwd ;
    Invoke-Sqlcmd -ServerInstance $Instance -Database master -Query "SELECT db_name(), count(*) as TblCnt from sys.tables"
}



foreach ($db in invoke-sqlcmd -query "SELECT name  FROM sys.databases WHERE owner_sid !=0x01" -database master -serverinstance ALIEN15 )
{
    #$db.name;
    #Invoke-sqlcmd -Query 'SELECT db_name() as DB,  name as TblName FROM sys.tables' -ServerInstance  ALIEN15 -Database $($db.name)
    $svr = "dfin.database.windows.net,1433";
    $db = 'AW2016';
    $user = 'wmiller';
    $pwd = 'Junebug1';

    #$DBQuery = readScriptFile  "D:\temp\TestCmd.sql";
 
    invoke-sqlcmd -Query 'SELECT db_name() as DB,  name as count(*) as TblCNT FROM sys.tables'  -serverinstance "$svr" -database "$db" -Username $user -Password $pwd;

}