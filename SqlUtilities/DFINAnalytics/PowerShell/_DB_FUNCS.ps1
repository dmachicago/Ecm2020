
Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\_DB_FUNCS.ps1
function setDMO_Server($SrvName, $Database,  $uid, $pw){
    
    Import-Module D:\dev\SQL\DFINAnalytics\PowerShell\_DB_FUNCS.ps1
    $mySrvConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
    $mySrvConn.ServerInstance=$SrvName
    $mySrvConn.LoginSecure = $false
    if ($uid){
        $mySrvConn.Login = $uid;
    }
    if ($pw){
        $mySrvConn.Password = $pw
    }
    $Server = new-object Microsoft.SqlServer.Management.SMO.Server($mySrvConn);
    return $Server;
}

function setMasterConn($Server, $Database,  $uid, $pw){
    $global:MstrConn = _setConn $Server $Database  $uid $pw;
}

function ckTemDbProcExists ($ProcName, $svr, $db, $uid, $pw){
    $rc = 0 ;
    $ConnStr = _genConnStr $svr $db $uid $pw ;
    $fqn = "tempdb..#$ProcName";
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection $ConnStr;
    $SqlConnection.Open()

    $sqlCommand = $SqlConnection.CreateCommand()
    $sqlCommand.CommandText="select object_id('tempdb..#$ProcName') "

    write-host "CMD TEXT: " + $sqlCommand.CommandText;
    $rc = $sqlCommand.ExecuteScalar();
    $rc
    if($rc -ne 0){
          Write-Host 'Your stored procedure was found' -fore green
          $rc = 1 ;
    }else{
          Write-Host 'Your stored procedure was NOT found' -fore red
          $rc = 0 ;
    }
    $SqlConnection.Close()
    return $rc ;
}

function readScriptFile ($ScriptFqn){
    # $ScriptFqn = "D:\temp\TestCmd.sql" ;
    $text = Get-Content $ScriptFqn ;
    return $text;
}

function _genConnStr ([string]$svr, [string] $db, [string]$uid, [string]$pw) {
    [string]$cs1 = '';
    $cs1 = 'NA';
    if (! $uid) {
        Write-Host ("Trusted CONNECTION")
        if (!$db) {
            $cs1 = "Server = $svr; Integrated Security = True;"
        }
        else {
            $cs1 = "Server = $svr; database=$db; Integrated Security = True;"
        }
        
    }
    else {
        Write-Host ("SQL Authentication CONNECTION")
        if (! $uid) {
            $cs1 = "Server = $svr; User ID = $uid; Password = $pw;"
        }
        else {
            $cs1 = "Server = $svr;database=$db; User ID = $uid; Password = $pw;"
        }
        
    }
    return $cs1 ;
}


function _prepConnStr ($uid, $pw) {
    $CS = "" ;
    if ($uid -eq ''){
        $CS= "data source = $Server; trusted_connection = true;"
        Write-Host ("Trusted CONNECTION")
    }
    else{
        #$Connection.ConnectionString = "Data Source=$svr;database=$db;User Id=sa; Password=Junebug1;"
        $CS = "Data Source=$svr; User Id=sa; Password=Junebug1;"
        Write-Host ("SQL Authentication CONNECTION")
    }

    Write-Host ("CONNECTION STRING: $CS")
    return $CS;
}

function _changeSvrConnection ($svr, $db, $uid, $pw){
    
    $cs= _genConnStr $svr $db $uid $pw ;

    $Connection = New-Object System.Data.SQLClient.SQLConnection
    $Connection.ConnectionString = $cs;
    $Connection.Open()
    
    Write-Host ("DB CONNECTION Changed: $Connection.state ")
    return $Connection;
}

function _setConn ($svr, $db, $uid, $pw){
    $cs= _genConnStr $svr $db $uid $pw ;
    $Connection = New-Object System.Data.SQLClient.SQLConnection
    $Connection.ConnectionString = $cs;
    $Connection.Open()
    return $Connection;
}


# executes a query to get row count in a table
#function _getTblRowCntMstrConn ($CNX, $Server, $Database,$TgtSchema, $tbl) {
function _getTblRowCntMstrConn ($Database, $TgtSchema, $tbl) {

    [string] $qry= $("SELECT count(*) FROM [$Database].[$TgtSchema].[$tbl]")

    $cmd = New-Object System.Data.SQLClient.SQLCommand;
    #$cmd.Connection = $CNX;
    $cmd.Connection = $global:MstrConn
    $cmd.CommandText = $qry;
    $cnt = [int32] $cmd.ExecuteScalar();
    #$DT.Load($Reader);
    
    Write-Host ("FROM FUNC: $cnt rows")

    return $cnt
}



# executes a query to get row count in a table
function _getTableRowCnt ($Server, $Database,$TgtSchema, $tbl, $uid, $pw) {

    $connstr= _genConnStr $Server $Database $uid $pw ;

    [string] $qry= $("SELECT count(*) FROM [$Database].[$TgtSchema].[$tbl]")

    $conn = New-Object System.Data.SQLClient.SQLConnection
    $conn.ConnectionString = $connstr;
    $conn.Open();
    $cmd = New-Object System.Data.SQLClient.SQLCommand;
    $cmd.Connection = $conn;
    $cmd.CommandText = $qry;
    $cnt = [int32] $cmd.ExecuteScalar();
    $conn.Close();
    
    Write-Host ("FROM FUNC: $cnt rows")

    return $cnt
}

function _createTempProc ($Server, $Database, $proccode, $uid,$pw ) {
    [string] $SQLQuery= $proccode;
    

    #$Connection = New-Object System.Data.SQLClient.SQLConnection
    #$connstr= _genConnStr $Server $Database $uid $pw ;
    #$Connection.ConnectionString = $connstr
    #$Connection.Open()
    
    $Command = New-Object System.Data.SQLClient.SQLCommand
    $Command.Connection = $global:MstrConn ;
    $Command.CommandText = $proccode;
    
    $rc = $Command.ExecuteNonQuery();
    #$Connection.Close()
    return $rc;
}


function _dropTempProc ($Server, $Database, $FqnProc, $uid,$pw ) {
    [string] $SQLQuery= $("IF OBJECT_ID('tempdb..#$FqnProc') IS NOT NULL DROP PROC #$FqnProc");
    
    Write-Host ($SQLQuery);

    $Connection = New-Object System.Data.SQLClient.SQLConnection
    $connstr= _genConnStr $Server $Database $uid $pw ;
    
    $Connection.ConnectionString = $connstr
    $Connection.Open()
    
    $Command = New-Object System.Data.SQLClient.SQLCommand
    $Command.Connection = $Connection
    $Command.CommandText = $SQLQuery
    
    $rc = $Command.ExecuteNonQuery();
    $Connection.Close()
    return $rc;
}

function _getSPText ($Server, $Database, $FqnProc, $uid,$pw ) {
    [string] $SQLQuery= $("SELECT definition FROM sys.sql_modules  WHERE object_id = (OBJECT_ID(N'$FqnProc')); ");
    $sptext = '' ;
    $Connection = New-Object System.Data.SQLClient.SQLConnection
    $connstr= _genConnStr $Server $Database $uid $pw ;
    #$Connection.ConnectionString = "server='$Server';database='$Database';trusted_connection=true;"
    $Connection.ConnectionString = $connstr
    $Connection.Open()
    $Command = New-Object System.Data.SQLClient.SQLCommand
    $Command.Connection = $Connection
    $Command.CommandText = $SQLQuery
    $Reader = $Command.ExecuteReader()
    while ($Reader.Read()) {
         
         $sptext = $Reader.GetValue($1)
    }
    $Connection.Close()
    return $sptext;
}

# executes a query and populates the $datatable with the data
<#  USAGE:
$resultsDataTable = New-Object System.Data.DataTable;
$resultsDataTable = _ExecuteSqlQueryDT $Server $Database $UserSqlQuery $uid $pw ;
#>
function _ExecuteSqlQueryDT ($Server, $Database, $SQLQuery,$uid, $pw) {
    $Datatable = New-Object System.Data.DataTable
    
    #$Cstr= _prepConnStr $uid, $pw;
    $Cstr= _genConnStr $Server $Database $uid $pw ;
    $Connection = New-Object System.Data.SQLClient.SQLConnection
    #$Connection.ConnectionString = "server='$Server';database='$Database';trusted_connection=true;"
    $Connection.ConnectionString = $Cstr;
    $Connection.Open()
    $Command = New-Object System.Data.SQLClient.SQLCommand
    $Command.Connection = $Connection
    $Command.CommandText = $SQLQuery
    $Reader = $Command.ExecuteReader()
    $Datatable.Load($Reader)
    $Connection.Close()
    
    return $Datatable
}

$global:MstrConn = $null;
<#
clear 
$uid = 'sa';
$pw = 'Junebug1';
[string] $Server= "192.168.230.136";
#[string] $Server= "ALIEN15";
[string] $Database = "DFINanalytics";
[string] $TgtSchema = "dbo";
[string] $TgtTbl = "DFS_DB2Skip";
[string] $UserSqlQuery= $("SELECT * FROM $Database.[$TgtSchema].[$TgtTbl]");

$global:MstrConn = $null;
$global:MstrConn = _setConn $Server $Database  $uid $pw;

# declaration not necessary, but good practice
$resultsDataTable = New-Object System.Data.DataTable;
$resultsDataTable = _ExecuteSqlQueryDT $Server $Database $UserSqlQuery $uid $pw ;

[string] $UserSqlQuery= $("select top 10 db_name() as DB, S.name as [Schema] ,T.[name] as TBL from sys.tables T join sys.schemas S on S.schema_id = T.schema_id");
$DBTables = _ExecuteSqlQueryDT $Server $Database $UserSqlQuery $uid $pw ;

$TgtProc = "UTIL_findLocks";
$FqnProc = "$Database.$TgtSchema.$TgtProc";
#$FqnProc = "$TgtProc";

$UserSqlQuery = $("SELECT definition FROM sys.sql_modules  WHERE object_id = (OBJECT_ID(N'$FqnProc')); ");
$UserSqlQuery;

[string]$SP = _getSPText $Server $Database $FqnProc $uid $pw ;
$pos = $SP.IndexOf("CREATE ") ;
$pos = $pos + 7 ;
[string]$rightPart = $sp.Substring($pos)

$SP = "CREATE #" + $rightPart ;

$rc = _dropTempProc $Server $Database $TgtProc $uid  $pw 
$rc = _createTempProc $Server $Database $SP $uid $pw 


$cnt = _getTableRowCnt  $Server $Database $TgtSchema $TgtTbl $uid $pw ;

$I = _getTblRowCntMstrConn $Database $TgtSchema $TgtTbl;
$CN.close();

$CN = _changeSvrConnection $Server $Database $uid $pw;

Write-Host ("RECORD COUNT: $i");

#validate we got data
Write-Host ("The table contains: " + $resultsDataTable.Rows.Count + " rows");
Write-Host ("The table, $TgtTbl, contains: $cnt rows");

Write-Host ("*************** DONE ***************");
#$array = $SP.Split([Environment]::NewLine);
Write-Host ($SP);
#>