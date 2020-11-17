-- Prerequisite to writing an UNPIVOT query.  Creates table and adds data to table
USE AdventureWorks2012
GO
IF(OBJECT_ID('dbo.unPvt')) IS NOT NULL
DROP TABLE dbo.unPvt
GO
CREATE TABLE dbo.unPvt
(
SalesPersonID int,
Cust1 int,
Cust2 int,
Cust3 int,
Cust4 int,
Cust5 int,
Cust6 int
)
GO
INSERT INTO dbo.unPvt
(
SalesPersonID, Cust1, Cust2, Cust3, Cust4, Cust5, Cust6
)
VALUES
(274, 5, 6, 4, 2, 6, 7),
(275, 1, 7, 2, 3, 6, 8),
(276, 0, 2, 8, 9, 6, 3),
(277, 6, 3, 1, 7, 6, 1),
(278, 5, 4, 9, 0, 2, 0),
(279, 2, 1, 0, 1, 8, 9)
GO