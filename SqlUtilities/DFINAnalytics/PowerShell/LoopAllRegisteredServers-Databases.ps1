foreach ($RegisteredSQLs in dir -recurse SQLSERVER:\SQLRegistration\'Database Engine Server Group'\QA\ | where {$_.Mode -ne "d"} )
{
    foreach ($DBName in invoke-sqlcmd -query "SELECT name
                FROM sys.databases WHERE name not in ('model',
                    'master',
                    'tempdb',
                    'DBA'
                ) " -database master -serverinstance $RegisteredSQLs.ServerName )
            {
                invoke-sqlcmd -query 'SELECT *
                FROM sys.dm_db_index_usage_stats' -ServerInstance $RegisteredSQLs.ServerName -database $DBName.name
            } #EndOfTheFoundDatabasesLoop
} #EndOfTheRegisteredServerLoop