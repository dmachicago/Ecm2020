USE AdventureWorks2012;
GO
--Set the options to support indexed views
SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,
QUOTED_IDENTIFIER, ANSI_NULLS ON;

GO
--Check to see if a view with the same name already exists
IF(OBJECT_ID('Purchasing.vwPurchaseOrders')) IS NOT NULL
DROP VIEW Purchasing.vwPurchaseOrders
GO
--Create the view
CREATE VIEW Purchasing.vwPurchaseOrders
WITH SCHEMABINDING
AS
SELECT
poh.OrderDate,
pod.ProductID,
SUM(poh.TotalDue) TotalDue,
COUNT_BIG(*) POCount
FROM Purchasing.PurchaseOrderHeader poh
INNER JOIN Purchasing.PurchaseOrderDetail pod
ON poh.PurchaseOrderID = pod.PurchaseOrderID
GROUP BY poh.OrderDate, pod.ProductID
GO
--Add a unique clustered index
CREATE UNIQUE CLUSTERED INDEX CIX_vwPurchaseOrders_OrderDateProductID
ON Purchasing.vwPurchaseOrders(OrderDate, ProductID)