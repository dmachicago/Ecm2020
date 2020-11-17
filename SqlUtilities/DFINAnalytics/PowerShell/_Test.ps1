    $SVR = "ALIEN15";
    $DB = "AW2016";
    $RunID = 777 ;

    #$connString = "Server=$SVR;Database=$DB;Trusted_Connection=True"
    $connString = "Data Source=$SVR;database=$DB;User Id=sa; Password=Junebug1;"
    $connection = new-object System.Data.SqlClient.SqlConnection $connString
    $connection.Open()
 
    $Command = new-Object System.Data.SqlClient.SqlCommand("master.dbo.sp_UTIL_TrackTblReadsWrites", $connection)
    $Command.CommandType = [System.Data.CommandType]'StoredProcedure'

    $Command.Parameters.Add("@RunID", [System.Data.SqlDbType]"int")
    $Command.Parameters["@RunID"].Value = $RunID
               
        
    $Command.ExecuteNonQuery() | Out-Null

    $connection.Close() | Out-Null
    $Command.Dispose() | Out-Null
    $connection.Dispose() | Out-Null

    Write-Output $Command.CommandText $Command.Parameters