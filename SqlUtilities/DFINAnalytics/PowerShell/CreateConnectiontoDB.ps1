$svr = '192.168.230.136';
$db = 'DFINAnalytics';
#$ConnectionString = "data source = ALIEN15; initial catalog = DFINAnalytics; trusted_connection = true;"
$ConnectionString= "Data Source=$svr;database=$db;User Id=sa; Password=Junebug1;"
$ServerConnection = New-Object Microsoft.SqlServer.Management.Common.ServerConnection
$ServerConnection.ConnectionString = $ConnectionString

$SqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server($ServerConnection)

$SqlServer.Databases |
    Select-Object Name