[string] $Server= "ALIEN15"
[string] $Database = "DFINAnalytics"
[string] $UserSqlQuery= $("SELECT * FROM [sys].[databases]")

# declaration not necessary, but good practice
$resultsDataTable = New-Object System.Data.DataTable
$resultsDataTable = ExecuteSqlQuery $Server $Database $UserSqlQuery 

# executes a query and populates the $datatable with the data
function ExecuteSqlQuery ($Server, $Database, $SQLQuery) {
    $Datatable = New-Object System.Data.DataTable
    
    $Connection = New-Object System.Data.SQLClient.SQLConnection
    $Connection.ConnectionString = "server='$Server';database='$Database';trusted_connection=true;"
    $Connection.Open()
    $Command = New-Object System.Data.SQLClient.SQLCommand
    $Command.Connection = $Connection
    $Command.CommandText = $SQLQuery
    $Reader = $Command.ExecuteReader()
    $Datatable.Load($Reader)
    $Connection.Close()
    
    return $Datatable
}

#validate we got data
Write-Host ("The table contains: " + $resultsDataTable.Rows.Count + " rows")