use [AW2016];
--Select statement that adds missing index information
SELECT SalesOrderID, CarrierTrackingNumber, OrderQty, LineTotal
FROM Sales.SalesOrderDetail d
where d.UnitPrice < 200 and d.OrderQty > 1;
SELECT SalesOrderID, CarrierTrackingNumber, OrderQty, LineTotal
FROM Sales.SalesOrderDetail d
where d.OrderQty > 1;

--View missing index information
SELECT SalesOrderID, CarrierTrackingNumber, OrderQty, LineTotal
FROM Sales.SalesOrderDetail d
where d.UnitPrice < 200 and d.OrderQty > 1;
SELECT SalesOrderID, CarrierTrackingNumber, OrderQty, LineTotal
FROM Sales.SalesOrderDetail d
where d.OrderQty > 1;

--add index to resolve missing index information
CREATE NONCLUSTERED INDEX IDX_NC_SalesOrderDetail_OrderQty_UnitPrice
ON
[AW2016].[Sales].[SalesOrderDetail] ([OrderQty], [UnitPrice])
INCLUDE
([SalesOrderID], [CarrierTrackingNumber], [LineTotal]);

--view missing index information
use [AW2016];
SELECT SalesOrderID, CarrierTrackingNumber, OrderQty, LineTotal
FROM Sales.SalesOrderDetail d
where d.UnitPrice < 200 and d.OrderQty > 1;
SELECT SalesOrderID, CarrierTrackingNumber, OrderQty, LineTotal
FROM Sales.SalesOrderDetail d
where d.OrderQty > 1;