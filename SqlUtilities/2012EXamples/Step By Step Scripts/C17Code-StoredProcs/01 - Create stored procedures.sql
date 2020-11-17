USE AdventureWorks2012;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Patrick LeBlanc
-- Create date: 6/9/2012
-- Description: <Description,,> Get PurchaseOrder Information
-- =============================================
CREATE PROCEDURE dbo.PurchaseOrderInformation
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
END
GO