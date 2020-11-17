USE AdventureWorks2012;
GO
ALTER PROCEDURE [dbo].[PurchaseOrderInformation]
@EmployeeID int,
@OrderYear int = 2005
AS
BEGIN
SELECT
poh.PurchaseOrderID, pod.PurchaseOrderDetailID,
poh.OrderDate, poh.TotalDue, pod.ReceivedQty, p.Name ProductName
FROM Purchasing.PurchaseOrderHeader poh
INNER JOIN Purchasing.PurchaseOrderDetail pod
ON poh.PurchaseOrderID = pod.PurchaseOrderID
INNER JOIN Production.Product p
ON pod.ProductID = p.ProductID
WHERE
poh.EmployeeID = @EmployeeID AND
YEAR(poh.OrderDate) = @OrderYear
END

USE AdventureWorks2012;
EXEC [dbo].[PurchaseOrderInformation]
@EmployeeID = 258;

USE AdventureWorks2012;
EXEC [dbo].[PurchaseOrderInformation]
@EmployeeID = 258,
@OrderYear = 2006;