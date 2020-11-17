--Step 2 of Parition an index using T-SQL.  This index creates a clustered index on a table.
USE [AdventureWorks2012];
CREATE CLUSTERED INDEX CIX_PurchaseOrderHeader_OrderDate
ON dbo.PurchaseOrderHeader(OrderDate)
WITH(DROP_EXISTING = ON)
ON schPOOrderDate(OrderDate);