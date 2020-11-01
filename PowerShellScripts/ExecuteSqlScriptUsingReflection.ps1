function ExecuteSqlScriptSMO($SqlScript, $SrvName, $DbName, $UserID, $PW)
{
    #$SqlScript = "C:\temp\TestSql.sql"
    $sr = New-Object System.IO.StreamReader($SqlScript)
    $script2 = $sr.ReadToEnd()
    #Write-Host ("script2 lines = $script2.count()")
    $null = [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Connect ionInfo")
    $null = [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoEnum ")
    $null = [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")

    #$srvname="T410A\GINA"
    #$dbname="ECM.Library.FS"
    $mySrvConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
    $mySrvConn.ServerInstance=$srvname
    $mySrvConn.LoginSecure = $false
    $mySrvConn.Login = $UserID
    $mySrvConn.Password = $PW

    $Server = new-object Microsoft.SqlServer.Management.Smo.Server($mySrvConn)

    $db = $server.Databases[$dbname]
    $extype = [Microsoft.SqlServer.Management.Common.ExecutionTypes]::Default
    $RC = $db.ExecuteNonQuery( $script2, $extype)
    Write-Host "RC: $RC"
}