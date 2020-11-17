--Use the script to create a stored procedure that simulates a long running query
USE AdventureWorks2012;
IF(OBJECT_ID('dbo.uspGetDepartments')) IS NOT NULL
DROP PROC dbo.uspGetDepartments
GO
CREATE PROC dbo.uspGetDepartments
AS
SET NOCOUNT ON
WAITFOR DELAY '00:00:07'
SELECT * FROM HumanResources.Department
SET NOCOUNT OFF
GO

