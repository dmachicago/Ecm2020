

function _genConnStr ([string]$svr, [string] $db, [string]$uid, [string]$pw) {
    [string]$cs1 = '';
    $cs1 = 'NA';
    if (! $uid) {
        Write-Host ("Trusted CONNECTION")
        if (IsNullOrEmpty($db)) {
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

function _changeSvrDB ($svr, $db, $uid, $pw){
    
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

    if ($uid = ''){
        if (!$db){
        $staging = New-DatabaseConnection -ServerInstance "$svr"
        }
        else {
        $staging = New-DatabaseConnection -ServerInstance "$svr" -Database "$db" 
        }
    }
    else {
        if (! $db ){
            $staging = New-DatabaseConnection -ServerInstance "$svr" -Username "$uid" -Password "$pw"
        }
        else {
            $staging = New-DatabaseConnection -ServerInstance "$svr" -Database "$db" -Username "$uid" -Password "$pw"
        }
    }

    Write-Host ("CONNECTION Established: $staging.state ")    
    return $staging;
}


# executes a query to get row count in a table
#function _getRowCntCurrConn ($CNX, $Server, $Database,$TgtSchema, $tbl) {
function _getRowCntCurrConn ($Database, $TgtSchema, $tbl) {

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

# executes a query and populates the $datatable with the data
function _ExecuteSqlQuery ($Server, $Database, $SQLQuery,$uid, $pw) {
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

$uid = 'sa';
$pw = 'Junebug1';
#[string] $Server= "192.168.230.136";
[string] $Server= "ALIEN15";
[string] $Database = "AW2016";
[string] $TgtSchema = "Sales";
[string] $TgtTbl = "SalesOrderDetail";
[string] $UserSqlQuery= $("SELECT top 100 * FROM $Database.[$TgtSchema].[$TgtTbl]");

$global:MstrConn = $null;
$global:MstrConn = _setConn $Server $Database  $uid $pw;

# declaration not necessary, but good practice
$resultsDataTable = New-Object System.Data.DataTable;
$resultsDataTable = _ExecuteSqlQuery $Server $Database $UserSqlQuery $uid $pw ;

$cnt = _getTableRowCnt  $Server $Database $TgtSchema $TgtTbl $uid $pw ;

$I = _getRowCntCurrConn $Database $TgtSchema $TgtTbl;
$CN.close();

$CN = _changeSvrDB $Server $Database $uid $pw;

Write-Host ("RECORD COUNT: $i");

#validate we got data
Write-Host ("The table contains: " + $resultsDataTable.Rows.Count + " rows");
Write-Host ("The table contains: $cnt rows");

Write-Host ("*************** DONE ***************");
