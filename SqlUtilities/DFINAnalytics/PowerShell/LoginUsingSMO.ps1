
$srvname="ALIEN15"
$dbname="TempDB"
$mySrvConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
$mySrvConn.ServerInstance=$srvname
$mySrvConn.LoginSecure = $false
$mySrvConn.Login = "sa"
$mySrvConn.Password = "Junebug1"

$srv = new-object Microsoft.SqlServer.Management.SMO.Server($mySrvConn)
$db = $srv.Databases[$dbname]
　　
# Create stored procedure 
$sp = New-Object -TypeName Microsoft.SqlServer.Management.SMO.StoredProcedure `
-argumentlist $db, "#spPrintImmediate"
$sp.TextMode = $false
$type = [Microsoft.SqlServer.Management.SMO.DataType]::NVarChar(4000)
$param = New-Object -TypeName Microsoft.SqlServer.Management.SMO.StoredProcedureParameter `
-argumentlist $sp,"@MSG",$type
$param.IsOutputParameter = $true
$sp.Parameters.Add($param)
$sp.TextBody = "RAISERROR(@MSG, 10, 1) WITH NOWAIT;" 
$sp.Create()

$srv.ConnectionContext.Disconnect()