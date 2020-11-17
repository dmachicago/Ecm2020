Set-ExecutionPolicy RemoteSigned

Add-Type -AssemblyName "Microsoft.SqlServer.Smo"
#OR
#Add-Type -path "C:\Windows\assembly\GAC_MSIL\Microsoft.SqlServer.Smo\10.0.0.0__89845dcd8080cc91\Microsoft.SqlServer.Smo.dll"

$SQLServer = 'ALIEN15';
$SQLDBName = 'AW2016';
$uid = '' ;
$pwd = '' ;

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection;
if ($uid -eq '') {
    $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True;"
}
else {
    $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; User ID = $uid; Password = $pwd;"
}

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = 'StoredProcName'
$SqlCmd.Connection = $SqlConnection 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd 
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet) 
$SqlConnection.Close() 

$srv = new-Object Microsoft.SqlServer.Management.Smo.Server("Alien15")  
$db = New-Object Microsoft.SqlServer.Management.Smo.Database  
$db = $srv.Databases.Item("DFINAnalytics")  

Foreach ($tbl in $db.Tables)  
{  
   Write-Host $tbl.name 
}  

Foreach ($sp in $db.StoredProcedures)  
{  
   Write-Host $sp.Name;
}  