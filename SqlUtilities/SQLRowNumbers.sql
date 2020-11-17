USE InStock365;
GO
--WITH OrderedOrders AS
--(
--    SELECT SalesOrderID, OrderDate,
--    ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNumber
--    FROM Sales.SalesOrderHeader 
--) 
--SELECT SalesOrderID, OrderDate, RowNumber  
--FROM OrderedOrders 
--WHERE RowNumber BETWEEN 50 AND 60;

WITH AvailProducts AS
(
SELECT ROW_NUMBER() OVER(ORDER BY RowNbr DESC) AS Row
	  ,[RowNbr]
      ,[ShortTitle]
      ,[MinimumUnit]
      ,[UnitCost]
      ,[NbrReviews]
      ,[AvgRating]
      ,[ProdWeight]
      ,[ProdWeightUnit]
      ,[ProdHeight]
      ,[ProdHeightUnit]
      ,[ProdLength]
      ,[ProdLengthUnit]
      ,[QtyAvail]
      ,[brand]
      ,[colors]
      ,[materials]
      ,[inventory]
      ,[category]
      ,[subcategory]
      ,[image_small]
      ,[image_medium]
      ,[image_large]
      ,[item_weight]
      ,[on_sale]	  
  FROM [vProdMain]
  )
  SELECT Row 
    ,[RowNbr]
      ,[ShortTitle]
      ,[MinimumUnit]
      ,[UnitCost]
      ,[NbrReviews]
      ,[AvgRating]
      ,[ProdWeight]
      ,[ProdWeightUnit]
      ,[ProdHeight]
      ,[ProdHeightUnit]
      ,[ProdLength]
      ,[ProdLengthUnit]
      ,[QtyAvail]
      ,[brand]
      ,[colors]
      ,[materials]
      ,[inventory]
      ,[category]
      ,[subcategory]
      ,[image_small]
      ,[image_medium]
      ,[image_large]
      ,[item_weight]
      ,[on_sale]
  FROM [AvailProducts]
  where category ='tools' 
  and Row between 50 and 100
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
