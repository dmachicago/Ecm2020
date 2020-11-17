
USE:
exec GetUsersByID '1,2,7,9'
GO

--EXAMPLE PROC USING udf_ParseParms
create proc GetUsersByID (@delimitedIDs varchar(200))
as
SELECT  Employee.EmployeeID, Employee.FirstName, Employee.LastName,
        Employee.MiddleName
FROM    Employee 
INNER JOIN dbo.udf_ParseParms(@delimitedIDs, ',') tblID
ON Employee.EmployeeID = tblID.Id

GO

CREATE FUNCTION udf_ParseParms( @delimString varchar(255), @delim char(1)) 
RETURNS @paramtable 
TABLE ( Id int ) 
AS BEGIN

DECLARE @len int,
        @index int,
        @nextindex int

SET @len = DATALENGTH(@delimString)
SET @index = 0
SET @nextindex = 0


WHILE (@len > @index )
BEGIN

SET @nextindex = CHARINDEX(@delim, @delimString, @index)

if (@nextindex = 0 ) SET @nextindex = @len + 2

 INSERT @paramtable
 SELECT SUBSTRING( @delimString, @index, @nextindex - @index )


SET @index = @nextindex + 1

END
 RETURN
END
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
