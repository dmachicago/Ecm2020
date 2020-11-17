--Use this script to write a query with an expression
USE AdventureWorks2012;
SELECT
(SubTotal+TaxAmt)*1.05 AS TotalDue
FROM SaleS.SalesOrderHeader