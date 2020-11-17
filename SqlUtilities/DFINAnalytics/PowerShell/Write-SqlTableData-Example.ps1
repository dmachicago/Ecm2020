Get-Command -Name *SQL*TableData


Write-SqlTableData -InputData $datatable -ConnectionTimeout 15 -Credential WDM -DatabaseName DFINAnalytics -Passthru -SchemaName dbo -ServerInstance ALIEN15 -TableName DFS_TableStats -Timeout 15