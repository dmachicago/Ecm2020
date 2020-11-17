<#
#JOB_ UTIL_DefragAllIndexes
#exec DFINAnalytics.dbo.UTIL_DefragAllIndexes null, null, 30, 0, 1, -1;
#Weekly Saturday Minight Eastern Time
# @StartingDB   NVARCHAR(100), 
# @EndingDB     NVARCHAR(100), 
# @MaxPct       DECIMAL(6, 2)  = 30, 
# @PreviewOnly  INT           = 1, 
# @ReorgIndexes INT           = 0, 
# @RunID        VARCHAR(60)   = NULL
#
#IF @EndingDB IS NULL and @StartingDB is null ALL databases are processed
#IF @EndingDB IS NULL and @StartingDB is NOT null only database @StartingDB is processed
#
#>

Function ProcessAllDataBase([string]$serverInstance)
{
      [void][reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
        try {


        $results = @()

        $server = new-object Microsoft.SqlServer.Management.Smo.Server $serverInstance

        foreach ($db in $server.Databases)
        {
            $dbname = $db.Name
            $fileGroups = $db.FileGroups
            $tbls = $db.tables
            $intRow=0
            
        }

        Write-Output $results
    }
    catch [Exception] {
        Write-Error $Error[0]
        $err = $_.Exception
        while ( $err.InnerException ) {
            $err = $err.InnerException
            Write-Output $err.Message
        }
    }
}

#161267263
$EndDate=(GET-DATE)
$StartDate=[datetime]”01/01/2014 00:00”

$timediff = NEW-TIMESPAN –Start $StartDate –End $EndDate;
$timediff.TotalSeconds;

$ProcName = 'UTIL_DefragAllIndexes';
$SVR = 'dfin.database.windows.net,1433';
$DB = 'AW2016';

$UserID = 'willer';
$pwd = 'Junebug1';
$StartingDB = $null;
$EndingDB = $null;
$MaxPct = 32;
$PreviewOnly  = 1;
$ReorgIndexes = 0;
$RunID  = [math]::floor($timediff.TotalSeconds);
$RunID 


if ($UserID) {
        $connString = "Server=$SVR;database=$DB;User Id=$UserID; Password=$pwd;"
    }
    else {
        $connString = "Server=$SVR;Database=$DB;Trusted_Connection=True"
}

#$FromDate = Read-Host "Enter Start Date (MM-DD-YYYY)"
#$ToDate = Read-Host "Enter End Date (MM-DD-YYYY)"
 
$QueryText = "exec dbo.usp_GenerateMyReport '01-01-2012', '04-04-2012'"
 
$SqlConnection = new-object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = $connString
$SqlCommand = $SqlConnection.CreateCommand()
$SqlCommand.CommandText = "EXEC dbo.usp_GenerateMyReport @FromDate, @ToDate"
 
# Add parameters to pass values to the stored procedure
$SqlCommand.Parameters.AddWithValue("@FromDate", $FromDate) | Out-Null
$SqlCommand.Parameters.AddWithValue("@ToDate", $ToDate) | Out-Null
 
$DataAdapter = new-object System.Data.SqlClient.SqlDataAdapter $SqlCommand
$dataset = new-object System.Data.Dataset
 
Write-Host $DataAdapter.Fill($dataset) ' records have been exported.'
 