--Use this script to add a filter to an index
USE AdventureWorks2012;
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_OrderDate
ON Sales.SalesOrderHeader
(
OrderDate
)
INCLUDE(Status, AccountNumber)
WHERE(OnlineOrderFlag = 0)
WITH(DROP_EXISTING = ON);