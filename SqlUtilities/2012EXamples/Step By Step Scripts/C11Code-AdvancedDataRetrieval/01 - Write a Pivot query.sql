USE AdventureWorks2012;
SELECT SalesPersonID, [29486] AS Cust1, [29487] AS Cust2, [29488] AS Cust3,
[29491] AS Cust4,[29492] AS Cust5, [29512] AS Cust6
FROM
(
SELECT SalesOrderID, CustomerID, SalesPersonID
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
) AS p
PIVOT
(
COUNT(SalesORderID)
FOR CustomerID IN
(
[29486],[29487],[29488],[29491],[29492],[29512])
) AS pvt
ORDER BY SalesPersonID