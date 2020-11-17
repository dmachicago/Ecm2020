USE AdventureWorks2012;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Patrick LeBlanc
-- Create date: 6/8/2012
-- Description: Returns the line items for a given orderid
-- =============================================
CREATE FUNCTION dbo.GetOrderDetails
(
@SalesOrderID int
)
RETURNS TABLE
AS
RETURN
(
SELECT
sod.SalesOrderID,
sod.SalesOrderDetailID,
sod.CarrierTrackingNumber,
p.Name ProductName,
so.Description
FROM Sales.SalesOrderDetail sod
INNER JOIN Production.Product p
ON sod.ProductID = p.ProductID
INNER JOIN Sales.SpecialOffer so
ON sod.SpecialOfferID = so.SpecialOfferID
WHERE
sod.SalesOrderID = @SalesOrderID
)
GO

USE AdventureWorks2012;
SELECT *
FROM dbo.GetOrderDetails(43659);

SELECT *
FROM dbo.GetOrderDetails(43659, DEFAULT, NULL)