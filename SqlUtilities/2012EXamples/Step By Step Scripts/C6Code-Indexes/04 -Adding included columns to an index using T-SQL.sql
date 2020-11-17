--Use this script to add included columns to an index
USE AdventureWorks2012;
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_OrderDate
ON Sales.SalesOrderHeader
(
OrderDate
)
INCLUDE(Status, AccountNumber)
WITH(DROP_EXISTING = ON);