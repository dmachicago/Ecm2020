# Load SMO
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | Out-Null


#If you wanted to get this across all of the environment, for all of the 
#databases...and you don't mind using PowerShell... You will need to run this 
#from a machine that at least has SQL Server 2008 Management Studio installed.


function Get-TableSize ([string[]]$server) {
    foreach ($srv in $server) {
        $s = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $srv

        $s.Databases.Tables | 
            ? {-Not $_.IsSystemObject} | 
                Select @{Label="Server";Expression={$srv}},
                    @{Label="DatabaseName";Expression={$_.Parent}}, 
                    @{Label="TableName";Expression={$_.Name}}, 
                    @{Label="SizeKB";Expression={$_.DataSpaceUsed}}
    }
}
#As labeled the DataSpaceUsed SMO object outputs in "KB", you can modify this to 
#be the measurement of your choice by just putting the abbreviated reference for 
#it. So if I wanted "MB": $_.DataSpaceUsed/1MB.




function getRowCount($sqlConnection, $table, $where = "1=1") {
    
    $sqlQuery = "SELECT count(*) FROM $table WHERE $where"

    $row_count = [Int32] exec-query $sqlQuery -conn $sqlConnection;

    #$sqlConnection.Open()
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand($sqlQuery, $sqlConnection)
    $row_count = [Int32] $SqlCmd.ExecuteScalar()
    $sqlConnection.Close()
    return $row_count
}

Function ProcessAllDB($serverInstance, $uid, $pwd)
{
  [void][reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")

  Write-Output "serverInstance: $serverInstance" ;

    try {
    $Server = $serverInstance;
    $Connection = New-Object System.Data.SQLClient.SQLConnection;
    

    $AllTbls = @();
    $results = @();
    $server = new-object Microsoft.SqlServer.Management.Smo.Server $serverInstance;
    
    $uid ='sa';
    $pwd = 'Junebug1';
    $svr = '192.168.230.136';
    $db = 'master';
    if ($uid -EQ ""){
        $ConnectionString = "data source = $Server; initial catalog = $db; trusted_connection = true;"
    }
    else{
        #$Connection.ConnectionString = "Data Source=$svr;database=$db;User Id=sa; Password=Junebug1;"
        $Connection.ConnectionString = "Data Source=$svr; User Id=sa; Password=Junebug1;"
    }

    $ServerConnection = New-Object Microsoft.SqlServer.Management.Common.ServerConnection
    $ServerConnection.ConnectionString = $ConnectionString

    $SqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server($ServerConnection)


    Write-Output "serverInstance: $serverInstance";
    Write-Output "server: $server";
    Write-Output "UID: $uid";
    Write-Output "PW: $pwd";

    #foreach ($db in $server.Databases)
    foreach ($db in $SqlServer.Databases)
    {
        $dbname = $db.Name;
        $fileGroups = $db.FileGroups;
        $tbls = $db.tables;

        if ($uid -EQ ""){
            $CS = "data source = $Server; initial catalog = $db; trusted_connection = true;"
        }
        else{
            $CS = "Data Source=$svr; Data Source = $db User Id=sa; Password=Junebug1;"
            $ServerConnection = New-Object Microsoft.SqlServer.Management.Common.ServerConnection
        }
        
        $SConn = New-Object Microsoft.SqlServer.Management.Common.ServerConnection
        $SConn.ConnectionString = $CS;

        $NewSVR = New-Object Microsoft.SqlServer.Management.Smo.Server($ServerConnection)

        foreach ($tbl in $tbls) {
            Write-Output "ROWS Table: $dbname.$tbl";
            getRowCount $NewSvr $tbl "1=1" ; 
        }
        $intRow=0
        $SConn.Disconnect();
    }
    #Write-Output $AllTbls;
    #Write-Output $results;
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

#************************************************************************************
ProcessAllDB "ALIEN15" "" ""
#ProcessAllDB "192.168.230.136" "sa" "Junebug1"

#************************************************************************************
#$list = get-content .\ServerList.txt
#Get-TableSize -server $list | Out-GridView
##I prefer using Out-GridView initially to review the output, and it copies easily 
##straight into Excel for me. You can also output this to the other supported formats 
##of PowerShell if desired.
#
##TO USE:
#$count = getRowCount $dbConn 'the_table'
#
##In the function ([string[]]$server), the brackets "[]" mean the parameter accepts 
##an array of objects. So if you have your servers listed in a file you can call the 
##function like so:
#$list = get-content .\ServerList.txt
#Get-TableSize -server $list | Out-GridView