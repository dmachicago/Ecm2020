<#
W. Dale Miller
01/28/2017
This is a sample set of code that will create a stored procedure on 
a SQL Server.
#>

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") 
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO")
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") 

Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\_DB_FUNCS.ps1

$srvname="ALIEN15"
$dbname="DFINAnalytics"
$uid = $null;
$pw = $null;

<#
$mySrvConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
$mySrvConn.ServerInstance=$srvname
$mySrvConn.LoginSecure = $false
#$mySrvConn.Login = $null
#$mySrvConn.Password = $null

$Server = new-object Microsoft.SqlServer.Management.SMO.Server($mySrvConn)
#$Server = new-object Microsoft.SqlServer.Management.Smo.Server ('ALIEN15')
#>

#$Server = setDMO_Server($srvname, $dbname,  $uid, $pw);    

$mySrvConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
$mySrvConn.ServerInstance=$SrvName
$mySrvConn.LoginSecure = $false
if ($uid){
    $mySrvConn.Login = $uid;
}
if ($pw){
    $mySrvConn.Password = $pw
}
$Server = new-object Microsoft.SqlServer.Management.SMO.Server($mySrvConn);

$DataBase = $Server.Databases[$dbname]

$procname = 'test_GetAllTableNames';
$rc = ckTemDbProcExists $procname $srvname $dbname $uid $pw;

if($rc -eq 0 )
{
    $SP = new-object `
        Microsoft.SqlServer.Management.Smo.StoredProcedure `
        ($DataBase, "test_GetAllTableNames", "dbo")
    
    $SP.TextMode = $false
    $SP.AnsiNullsStatus = $false
    $SP.QuotedIdentifierStatus = $false
    
    $SP.TextBody = "Select name from sys.tables order by name"

    $SP.Create()
}
$Server.ConnectionContext.Disconnect()