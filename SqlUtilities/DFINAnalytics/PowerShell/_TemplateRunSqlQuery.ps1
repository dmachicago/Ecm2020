#Create a Connection
$sqlConn = New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString = “Server=Alien15;Integrated Security=true;Initial Catalog=master”
$sqlConn.Open()

#Create Your Command
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $sqlConn
$query = “SELECT name, database_id FROM sys.databases”
$sqlcmd.CommandText = $query

#Create Your Data Adapter
$adp = New-Object System.Data.SqlClient.SqlDataAdapter $sqlcmd

#Create Your DataSet (and fill it)
$data = New-Object System.Data.DataSet
$adp.Fill($data) | Out-Null

#Retrieving Your Data
#$data.Tables
<# or #>
$data.Tables[0]



<#
## – Set PowerShell variables:
$ConnectionString = ‘server=ALIEN14;database=DFINAnalytics;Integrated Security=false;User ID=sa;Password=Junebug1’;
$TSQLQuery = "Select * from sys.databases;";

## – Connect and Execute Stored-Procedure:
$sda = New-Object System.Data.SqlClient.SqlDataAdapter ($TSQLQuery, $ConnectionString);
$sdt = New-Object System.Data.DataTable;
$sda.fill($sdt) | Out-Null;
$sdt.Rows;
#>