#Add-Type -AssemblyName "Microsoft.SqlServer.Smo"
#load assemblies
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
#Need SmoExtended for backup
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") | Out-Null

#create database
$srv= new-Object Microsoft.SqlServer.Management.Smo.Server("(local)")
$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database -argumentlist $srv, "PowerDatabase"
$db.Create()　

#Create the Table
$db= New-Object Microsoft.SqlServer.Management.Smo.Database
$db= $srv.Databases.Item("PowerDatabase")
$tb = new-object Microsoft.SqlServer.Management.Smo.Table($db, "PowerTable")
$col1 = new-object Microsoft.SqlServer.Management.Smo.Column($tb,"Name", [Microsoft.SqlServer.Management.Smo.DataType]::NChar(50))
$col2 = new-object Microsoft.SqlServer.Management.Smo.Column($tb, "ID", [Microsoft.SqlServer.Management.Smo.DataType]::Int)$tb.Columns.Add($col1)
$tb.Columns.Add($col2)
$tb.Create()　
　　
# Create stored procedure 
$sp = New-Object -TypeName Microsoft.SqlServer.Management.SMO.StoredProcedure `
-argumentlist $db, "PowerStoredProcedure"
$sp.TextMode = $false
$type = [Microsoft.SqlServer.Management.SMO.DataType]::NVarChar(50)
$param = New-Object -TypeName Microsoft.SqlServer.Management.SMO.StoredProcedureParameter `
-argumentlist $sp,"@retval",$type
$param.IsOutputParameter = $true
$sp.Parameters.Add($param)
$sp.TextBody = " SELECT @retval = (SELECT Name FROM dbo.PowerTable)" 
$sp.Create()