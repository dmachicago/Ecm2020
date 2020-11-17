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
    $sqlConnection.Open()
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand($sqlQuery, $sqlConnection)
    $row_count = [Int32] $SqlCmd.ExecuteScalar()
    $sqlConnection.Close()
    return $row_count
}

Function Get-FSqlDBFileSizes([string]$serverInstance)
{
  [void][reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
    try {


    $results = @()

    $server = new-object Microsoft.SqlServer.Management.Smo.Server $serverInstance

    foreach ($db in $server.Databases)
    {
        $dbname = $db.Name
        $fileGroups = $db.FileGroups
        $tbls = $db.tables
        $intRow=0
        foreach ($fg in $fileGroups) {
            If ($fg) {
                $intRow++

                $mdfInfo = $fg.Files | Select Name, FileName, size, UsedSpace
                $result = New-Object -TypeName PSObject -Property @{
                    DBName = $dbname
                    Name = $mdfInfo.Name
                    FileName = $mdfInfo.FileName
                    Size = ($mdfInfo.size / 1000)
                    UsedSpace = ($mdfInfo.UsedSpace / 1000)
                }
                $results += $result

                $logInfo = $db.LogFiles | Select Name, FileName, Size, UsedSpace
                $result = New-Object -TypeName PSObject -Property @{
                    DBName = $dbname
                    Name = $logInfo.Name
                    FileName = $logInfo.FileName
                    Size = ($logInfo.size / 1000)
                    UsedSpace = ($logInfo.UsedSpace / 1000)
                }
                $results += $result
            }
        }
        foreach ($tbl in $tbls) {
            
        }
    }

    Write-Output $results
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
Get-FSqlDBFileSizes("ALIEN15")

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