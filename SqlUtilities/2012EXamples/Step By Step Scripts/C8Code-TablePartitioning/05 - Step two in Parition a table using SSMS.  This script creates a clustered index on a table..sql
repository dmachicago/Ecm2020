--Step two in Parition a table using SSMS.  This script creates a clustered index on a table.
USE [AdventureWorks2012];
CREATE CLUSTERED INDEX CIX_PurchaseOrderHeader_OrderDate
ON dbo.PurchaseOrderHeader(OrderDate)