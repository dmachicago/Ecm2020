
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = “Server=Alien15;Integrated Security=true;Initial Catalog=DFINAnalytics”

$sqlConnection.Open()
$sqlCommand = New-Object System.Data.SqlClient.SqlCommand
$sqlCommand.Connection = $sqlConnection
$sqlcommand.commandtext = "test_GetNbr1"
$sqlCommand.CommandType = [System.Data.CommandType]::StoredProcedure
$result = $sqlCommand.executereader()
$table = new-object “System.Data.DataTable”
$table.Load($result)
$PLF = $table.Rows[0].Value
$sqlConnection.close() ;
Write-host 'DONE:';
Write-host $table.Rows[0];
Write-host $table.Rows[1];
Write-host $PLF ;