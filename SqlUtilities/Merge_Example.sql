
MERGE SalesArchive AS SA
USING
(
    SELECT CustomerID, LoadDate = MIN(CONVERT(VARCHAR(8), GETDATE(), 112)), TotalSalesAmount = SUM(SaleAmount), TotalSalesCount = COUNT(*)
    FROM SalesFeed
    GROUP BY CustomerID
) AS CTE(CustomerID, LoadDate, TotalSalesAmount, TotalSalesCount)
ON SA.CustomerID = CTE.CustomerID
   AND SA.SalesDate = CTE.LoadDate
    WHEN NOT MATCHED
    THEN
      INSERT(CustomerID, SalesDate, TotalSalesAmount, TotalSalesCount, CreationDate, UpdatedDate)
      VALUES
(
   CTE.CustomerID, 
   CTE.LoadDate, 
   CTE.TotalSalesAmount, 
   CTE.TotalSalesCount, 
   GETDATE(), 
   GETDATE()
)
    WHEN MATCHED
    THEN UPDATE SET SA.TotalSalesAmount = SA.TotalSalesAmount + CTE.TotalSalesAmount, 
                    SA.TotalSalesCount = SA.TotalSalesCount + CTE.TotalSalesCount, 
                    SA.UpdatedDate = GETDATE();
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016