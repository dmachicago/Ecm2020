﻿cls
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
$query = "get_Tables";
#$query = "select name from sys.tables order by name";
$cmd = New-Object System.Data.SqlClient.SqlCommand
$cmd.Connection = $conn
$cmd.CommandType = [System.Data.CommandType]"StoredProcedure"
#$cmd.CommandType = [System.Data.CommandType]"text"
$cmd.CommandText = $Query

#$cmd.Parameters.Add("@TblName", [System.Data.SqlDbType]::text) | Out-Null
#$cmd.Parameters["@TblName"].Value = 'BusinessEntityContact';
#$cmd.Parameters.Add("@TSchema", [System.Data.SqlDbType]::text) | Out-Null
#$cmd.Parameters["@TSchema"].Value = 'Person'

# load it right into a DataTable
$dt = New-Object System.Data.DataTable
$dt.Load($cmd.ExecuteReader())
$dt.data
$dt.log

$a = '';
$b = 0;

foreach ($Row in $dt.Tables[0].Rows)
{
    $a =  $Row.TableName ;
    $b =  $Row.RowCount ;
    write-host "TBL : $a : $b)"
}

$conn.Close()