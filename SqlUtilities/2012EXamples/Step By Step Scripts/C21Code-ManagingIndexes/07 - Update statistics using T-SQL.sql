USE AdventureWorks2012
GO
--Update all statistics within the AdventureWorks2012 database
EXEC sp_updatestats
GO
--Update all statistics for a given index on the specified table
UPDATE STATISTICS [Sales].[SalesOrderHeader] [IX_SalesOrderHeader_OrderDate]
GO