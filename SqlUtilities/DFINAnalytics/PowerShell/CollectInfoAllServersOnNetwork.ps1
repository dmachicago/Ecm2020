#Collecting information about the SQL Servers in your network

$Servers = "SQL2005", "SQL2008", "SQL2008R2"
    $Query = "SELECT SERVERPROPERTY('ServerName') AS ServerName
                ,SERVERPROPERTY('ProductVersion') AS ProductVersion
                ,SERVERPROPERTY('ProductLevel') AS ProductLevel
                ,SERVERPROPERTY('Edition') AS Edition
                ,SERVERPROPERTY('EngineEdition') AS EngineEdition;"
    $Servers | ForEach-Object{
 $server = "$_";
 Set-Location SQLSERVER:\SQL\$server Invoke-Sqlcmd -Query $Query -ServerInstance $server;
 }

#The script will be executed against each database of each SQL instance.

$Servers = "SQL2005", "SQL2008", "SQL2008R2" 
    $InputFile = "C:\MyLocation\RevokeGuest.sql";
    $Servers | ForEach-Object{
 $server = "$_";
 Set-Location SQLSERVER:\SQL\$server\DEFAULT\DATABASES;
 Get-ChildItem | ForEach-Object{
 $Db = $_.Name;
 Invoke-Sqlcmd -SuppressProviderContextWarning -InputFile $InputFile -Database $Db;
     }
    }


#Collecting information about the databases from a SQL Server instance
#Over time, you'll add complexity to your admin and maintenance scripts. 
#However, the "core" of the script may be straightforward. The next example 
#shows you how easy will be to collect information about the databases from 
#a SQL instance and to export this information in a csv file:

    $OutFile = "C:\MyLocation\OutFile.csv"
    Set-Location SQLSERVER:\SQL\MyServer\DEFAULT\DATABASES
    Get-ChildItem | Select-Object Name, Status | Export-csv -NoTypeInformation $OutFile
