

function getRowCount($sqlConnection, $table, $where = "1=1") {
    
    $sqlQuery = "SELECT count(*) FROM $table WHERE $where"
    $sqlConnection.Open()
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand($sqlQuery, $sqlConnection)
    $row_count = [Int32] $SqlCmd.ExecuteScalar()
    $sqlConnection.Close()
    return $row_count
}

function execSp ($connection, $SpName) {

}

$TgtServer = "ALIEN15";
$DB = 'DFINAnalytics';

$connString = "Server=$TgtServer;Database=$DB;Trusted_Connection=True"

$connection = new-object System.Data.SqlClient.SqlConnection $connString

$connection.Open()

$Command = new-Object System.Data.SqlClient.SqlCommand("sp_UTIL_TrackTblReadsWrites", $connection)

$Command.CommandType = [System.Data.CommandType]"StoredProcedure"

$Command.Parameters.Add("@Serverid", [System.Data.SqlDbType]"int")

$Command.Parameters.Add("@Reason","") | out-null

$Command.Parameters["@Reason"].Direction = [system.Data.ParameterDirection]::Output

$Command.ExecuteNonQuery() | Out-Null

$NotWhitelisted = $Command.Parameters["@CanGrow"].value

$WhitelistedReason = $Command.Parameters["@Reason"].value

$connection.Close() | Out-Null

$Command.Dispose() | Out-Null

$connection.Dispose() | Out-Null