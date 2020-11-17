-- createViewUsingCTE

CREATE VIEW vSalesStaffQuickStats
AS
  WITH SalesBySalesPerson (SalesPersonID, NumberOfOrders, MostRecentOrderDate)
      AS
      (
            SELECT SalesPersonID, COUNT(*), MAX(OrderDate)
            FROM Sales.SalesOrderHeader
            GROUP BY SalesPersonID
      )
  SELECT E.EmployeeID,
         EmployeeOrders = OS.NumberOfOrders,
         EmployeeLastOrderDate = OS.MostRecentOrderDate,
         E.ManagerID,
         ManagerOrders = OM.NumberOfOrders,
         ManagerLastOrderDate = OM.MostRecentOrderDate
  FROM   HumanResources.Employee AS E
       INNER JOIN SalesBySalesPerson AS OS
         ON E.EmployeeID = OS.SalesPersonID
       LEFT OUTER JOIN SalesBySalesPerson AS OM
         ON E.ManagerID = OM.SalesPersonID
GO
 
-- T-SQL test view
SELECT * FROM vSalesStaffQuickStats
ORDER BY EmployeeID
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
