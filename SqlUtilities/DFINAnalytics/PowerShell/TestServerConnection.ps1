#Find-Module -Name "Sql*" 


Import-Module SqlServer;

Invoke-Sqlcmd -ServerInstance '.\ALIEN15' -Database 'DFINAnalytics' -InputFile 'D:\dev\SQL\DFINAnalytics\create_master_seq.sql' | 
    Out-File -FilePath "C:\TEMP\_output.XXX"



$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = “Server=Alien15;Integrated Security=true;Initial Catalog=master”
$SqlConnection.Open()
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand


$SqlCmd.CommandText = "sp_helpdb"
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$SqlConnection.Close()
$DataSet.Tables[0]