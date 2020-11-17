--Create a clustered index using T-SQL
USE AdventureWorks2012;
CREATE CLUSTERED INDEX CIX_DatabaseLog_PostTime
ON dbo.DatabaseLog
(
PostTime DESC
)
WITH(DROP_EXISTING = ON);