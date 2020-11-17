--Use this code to create a partition function
USE AdventureWorks2012;
CREATE PARTITION SCHEME schPOOrderDate
AS PARTITION fnPOOrderDate
TO(Sales2005, Sales2006, Sales2007, Sales2008, Sales2009)