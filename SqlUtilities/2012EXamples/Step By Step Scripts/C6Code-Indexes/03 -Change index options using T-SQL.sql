--Use this script to add index options to an index
USE AdventureWorks2012;
CREATE CLUSTERED INDEX CIX_DatabaseLog_PostTime
ON dbo.DatabaseLog
(
PostTime DESC
)
WITH(DROP_EXISTING = ON, SORT_IN_TEMPDB = ON, FILLFACTOR = 80, PAD_INDEX = ON);