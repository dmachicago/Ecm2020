Function processDatabases($svr, $RunID)
{

   Write-Output "@2: $svr";
   Write-Output "@3: $RunID";

  [void][reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
    try {
        $results = @()
        #$server = new-object Microsoft.SqlServer.Management.Smo.Server $svr
        $server = new-object ('Microsoft.SqlServer.Management.Smo.Server') "$svr" 
        foreach ($db in $server.Databases)
        {
            $dbname = $db.Name
            Write-Output $SVR $dbname $RunID;
            ExecSP_UTIL_TrackTblReadsWrites $SVR $db $RunID;            
        }
    }
    catch [Exception] {
        Write-Output "*************************";
        Write-Error $Error[0]
        $err = $_.Exception
        while ( $err.InnerException ) {
            $err = $err.InnerException
            Write-Output $err.Message
        }
    }

}

Function ExecSP_UTIL_TrackTblReadsWrites($SVR, $DB, $RunID)
{

    try
    {
    Write-Output "@3 $SVR, $DB, $RunID";

    #$connString = "Server=$SVR;Database=$DB;Trusted_Connection=True"
    #$connString = "Data Source=$SVR;database=$DB;User Id=sa; Password=Junebug1;"
    $connString = "Server=$SVR;database=$DB;User Id=sa; Password=Junebug1;"

    Write-Output $connString

    $connection = new-object System.Data.SqlClient.SqlConnection $connString
    $connection.Open()
 
    $Command = new-Object System.Data.SqlClient.SqlCommand("DFINAnalytics.dbo.sp_UTIL_TrackTblReadsWrites", $connection)
    $Command.CommandType = [System.Data.CommandType]'StoredProcedure'

    $Command.Parameters.Add("@RunID", [System.Data.SqlDbType]"int")
    $Command.Parameters["@RunID"].Value = $RunID
                       
    $Command.ExecuteNonQuery() | Out-Null

    $connection.Close() | Out-Null
    $Command.Dispose() | Out-Null
    $connection.Dispose() | Out-Null
    }
    catch
    {
        Write-Output "ERROR: $SVR, $DB, $RunID, $SqlCommand.CommandText ";
    }

    Write-Output $SqlCommand.CommandText
}

#set-executionpolicy remotesigned -force
#get-psprovider

$SVR = 'ALIEN15';
$DB = 'DFINAnalytics';
#$DB = 'AW2016';
$RunID = 888;

#processDatabases $SVR $RunID ;
ExecSP_UTIL_TrackTblReadsWrites $SVR $DB $RunID;

$SVR = 'ALIEN15';
$DB = 'TestDB';
$DB = 'AW2016';
$RunID = 888;

#processDatabases $SVR $RunID ;
ExecSP_UTIL_TrackTblReadsWrites $SVR $DB $RunID;