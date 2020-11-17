d:
cd D:\dev\SQL\DFINAnalytics\BATCH_FILES

$IVPFILE = "D:\dev\SQL\DFINAnalytics\BATCH_FILES\IVP_DFINAnalytics.sql"
if (Test-Path $IVPFILE) 
{
  Remove-Item $IVPFILE
}

Get-Content D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql,D:\dev\SQL\DFINAnalytics\createSeq2008.sql | add-content D:\dev\SQL\DFINAnalytics\createSeq2008.sql;