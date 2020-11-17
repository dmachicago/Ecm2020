#$connString = "Data Source=ALIEN15;Initial Catalog=AW2016;User Id='sa'; Password='Junebug1';"
$connString = "Data Source=ALIEN15;Initial Catalog=AW2016;"
 
#$FromDate = Read-Host "Enter Start Date (MM-DD-YYYY)"
#$ToDate = Read-Host "Enter End Date (MM-DD-YYYY)"
$parm1 = 'This is the first parameter';
$parm2 = 2019;
 
$QueryText = "exec UTIL_TestDBProcCallWithParms $parm1, $parm2"
 
$SqlConnection = new-object System.Data.SqlClient.SqlConnection;
$SqlConnection.ConnectionString = $connString;
$SqlConnection.open();
$SqlCommand = $SqlConnection.CreateCommand();
$SqlCommand.CommandText = "EXEC dbo.usp_GenerateMyReport $parm1, $parm2";
 
# Add parameters to pass values to the stored procedure
$SqlCommand.Parameters.AddWithValue("$parm1", $parm1) | Out-Null
$SqlCommand.Parameters.AddWithValue("$parm2", $parm2) | Out-Null

$SqlCommand.ExecuteNonQuery() | Out-Null
<# 
$DataAdapter = new-object System.Data.SqlClient.SqlDataAdapter $SqlCommand
$dataset = new-object System.Data.Dataset

 
Write-Host $DataAdapter.Fill($dataset) ' records have been exported.'
$dataset.Tables[0] | Export-CSV C:\MyReport.csv -Force
 
Write-Host 'New report C:\MyReport.csv has been successfully generated'
#>

$SqlConnection.Close();