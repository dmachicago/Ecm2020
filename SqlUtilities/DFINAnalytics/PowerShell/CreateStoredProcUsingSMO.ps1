[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") | Out-Null

function _genConnStr ([string]$svr, [string] $db, [string]$uid, [string]$pw) {
    [string]$cs1 = '';
    $cs1 = 'NA';
    if (! $uid) {
        Write-Host ("Trusted CONNECTION")
        if (! $db) {
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


function execSp ($spName,$svr, $dbname, $UserID, $pwd){
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection;
    $SqlConnection.ConnectionString = _genConnStr $svr $dbname $UserID $pw;
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand;
    $SqlCmd.CommandText = $spname;
    $SqlCmd.Connection = $SqlConnection;

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $SqlCmd;

    $DataSet = New-Object System.Data.DataSet;
    $SqlAdapter.Fill($DataSet);
    $SqlConnection.Close();
    $DataSet.Tables[0];
}

function attachServer ($srvname, $dbname, $UserID, $pwd ) {
    $mySrvConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection;
    $mySrvConn.ServerInstance=$srvname;
    $mySrvConn.LoginSecure = $false;
    if ($UserID){
        $mySrvConn.Login = $UserID;
    }
    if ($pwd){
        $mySrvConn.Password = $pwd;
    }
    $srv = new-object Microsoft.SqlServer.Management.SMO.Server($mySrvConn);
    return $srv ;
}

function detachServer ($svr) {
    $rc = 0 ;
    try{
        $srv.ConnectionContext.Disconnect();
        $rc = 1 ;
    }
    catch {
        $rc = 0 ;
    }
}

function getSpSql ($fqn){
    $content = [IO.File]::ReadAllText($fqn) ;
    return $content;
}

#function createTempDB_StoredProc ($srvname, $dbname, $UserID, $pwd )
function createTempDB_StoredProc ($svr, $dbname, $sp, $sql ) {

    #$db = $srv.Databases[$dbname];
　　
    # Create stored procedure 
    $sp = New-Object -TypeName Microsoft.SqlServer.Management.SMO.StoredProcedure -argumentlist $dbname, "#spPrintImmediate";
    $sp.TextMode = $false;
    $type = [Microsoft.SqlServer.Management.SMO.DataType]::NVarChar(4000);
    $param = New-Object -TypeName Microsoft.SqlServer.Management.SMO.StoredProcedureParameter -argumentlist $sp,"@MSG",$type;
    $param.IsOutputParameter = $true;
    $sp.Parameters.Add($param);
    $sp.TextBody = "RAISERROR(@MSG, 10, 1) WITH NOWAIT;" ;
    $sp.Create();
        
}

$srvname="ALIEN15"
$dbname="DFINAnalytics"
$UserID = $null; 
$pwd = $null;

$spName = 'UTIL_QryPlanStats';
$ProcDependencies = execSp $spName $srvname $dbname $UserID $pwd;

$fqn = 'D:\dev\SQL\DFINAnalytics\PrintImmediate_TempDB.sql';
$sql = getSpSql ($fqn)

$sql

$smosrv = attachServer $srvname $dbname $UserID $pwd ;
createTempDB_StoredProc $smosrv $dbname $spName $sql
#createTempDB_StoredProc $srvname $dbname $UserID $pwd ;

detachServer $smosrv;