# Executes a Stored Procedure from Powershell and returns the first output DataTable
function Exec-Sproc{
	param($Conn, $Sproc, $Parameters=@{})

	$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
	$SqlCmd.CommandType = [System.Data.CommandType]::StoredProcedure
	$SqlCmd.Connection = $Conn
	$SqlCmd.CommandText = $Sproc
	foreach($p in $Parameters.Keys){
 		[Void] $SqlCmd.Parameters.AddWithValue("@$p",$Parameters[$p])
 	}
	$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($SqlCmd)
	$DataSet = New-Object System.Data.DataSet
	[Void] $SqlAdapter.Fill($DataSet)
	$SqlConnection.Close()
	return $DataSet.Tables[0]
}

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = “Server=Alien15;Integrated Security=true;Initial Catalog=master”

#$Res = Exec-Sproc -Conn $SqlConnection -Sproc "sp_help" -Parameters @{objname="spt_values"}
$Res = Exec-Sproc -Conn $SqlConnection -Sproc "DFINAnalytics.dbo.UTIL_ListMostCommonWaits" 

foreach ($Row in $Res)
{ 
	write-host "output: $($Row[0])"
}