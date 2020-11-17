cls
Import-Module SQLPS -verbose

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

 
$svr = "ALIEN15"
$db = "AW2016"
$uid = $null
$pwd = $null
 
$ConnString = _genConnStr $svr $db $uid $pwd ;
 
$conn = New-Object System.Data.SqlClient.SqlConnection $ConnString
$conn.Open()
$query = "dbo.proc_QuickRowCount";
$query = "get_Tables";
#$query = "select name from sys.tables order by name";
$cmd = New-Object System.Data.SqlClient.SqlCommand
$cmd.Connection = $conn
$cmd.CommandType = [System.Data.CommandType]"StoredProcedure"
#$cmd.CommandType = [System.Data.CommandType]"text"
$cmd.CommandText = $Query

#$cmd.Parameters.Add("@TblName", [System.Data.SqlDbType]::text) | Out-Null
#$cmd.Parameters["@TblName"].Value = 'AddressType';
#$cmd.Parameters.Add("@TSchema", [System.Data.SqlDbType]::text) | Out-Null
#$cmd.Parameters["@TSchema"].Value = 'Person'
 
$DataAdapter = new-object System.Data.SqlClient.SqlDataAdapter $cmd
$dataset = new-object System.Data.Dataset
$AffectedRows = $DataAdapter.Fill($dataset)
$AffectedRows
$dataset.Tables[0]

#$cmd.ExecuteNonQuery() | Out-Null
$conn.Close()