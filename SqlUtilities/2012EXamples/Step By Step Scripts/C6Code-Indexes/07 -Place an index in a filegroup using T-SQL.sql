--Use this script to place an index in a filegroup
USE AdventureWorks2012;
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_OrderDate
ON Sales.SalesOrderHeader
(
OrderDate
)
INCLUDE(Status, AccountNumber)
WHERE(OnlineOrderFlag = 0)
WITH(DROP_EXISTING = ON)
ON AW2012FileGroup2;