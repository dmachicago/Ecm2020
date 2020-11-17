USE AdventureWorks2012
GO
SELECT SalesPersonID, Customer, Sales
FROM
(
SELECT SalesPersonID, Cust1, Cust2, Cust3, Cust4, Cust5, Cust6
FROM unPvt
) up
UNPIVOT
(
Sales FOR Customer IN
(
Cust1, Cust2, Cust3, Cust4, Cust5, Cust6
)
)AS unpvt;
GO