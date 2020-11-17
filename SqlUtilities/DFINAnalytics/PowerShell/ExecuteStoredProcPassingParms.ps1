$connString = "Server=$CentralmanagementServer;Database=$CMSdb_name;Trusted_Connection=True"

$connection = new-object System.Data.SqlClient.SqlConnection $connString

$connection.Open()

$Command = new-Object System.Data.SqlClient.SqlCommand("abc_can_datafile_be_grown", $connection)

$Command.CommandType = [System.Data.CommandType]'StoredProcedure'

$Command.Parameters.Add("@Serverid", [System.Data.SqlDbType]"int")

$Command.Parameters["@Serverid"].Value = [int]$DB.Serverid

$Command.Parameters.Add("@Databaseid", [System.Data.SqlDbType]"int")

$Command.Parameters["@Databaseid"].Value = [int]$DB.DatabaseId

$Command.Parameters.Add("@DatabaseName", $DB.DatabaseName)

$Command.Parameters.Add("@MonitorType", "GROWDATAFILE")

$Command.Parameters.Add("@CanGrow","")

$Command.Parameters["@CanGrow"].Direction = [system.Data.ParameterDirection]::Output

$Command.Parameters["@CanGrow"].DbType = [System.Data.DbType]'String';

$Command.Parameters.Add("@Reason","") | out-null

$Command.Parameters["@Reason"].Direction = [system.Data.ParameterDirection]::Output

$Command.ExecuteNonQuery() | Out-Null

$NotWhitelisted = $Command.Parameters["@CanGrow"].value

$WhitelistedReason = $Command.Parameters["@Reason"].value

$connection.Close() | Out-Null

$Command.Dispose() | Out-Null

$connection.Dispose() | Out-Null