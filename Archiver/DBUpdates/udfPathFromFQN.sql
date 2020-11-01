IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'Isfullpath')
          AND type IN(N'FN', N'IF', N'TF', N'FS', N'FT')
)
    DROP FUNCTION Isfullpath;
GO
CREATE FUNCTION dbo.Isfullpath
(@FullName VARCHAR(500)
)
RETURNS BIT
AS
     BEGIN
         DECLARE @result BIT;
         IF CHARINDEX('\', @FullName) = 0
             SET @result = 0;
             ELSE
             SET @result = 1;
         RETURN @result;
     END;
GO

IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'Pathfromfullname')
          AND type IN(N'FN', N'IF', N'TF', N'FS', N'FT')
)
    DROP FUNCTION Pathfromfullname;
GO

/*   HOW TO USE: 
SELECT dbo.Pathfromfullname('C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2\MSSQL\Log\system_health_0_131996396680890000.xel') 
*/

CREATE FUNCTION dbo.Pathfromfullname
(@FullName VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
     BEGIN
         DECLARE @result VARCHAR(500);
         IF(dbo.Isfullpath(@FullName) = 1)
             SELECT @result = LEFT(@FullName, LEN(@FullName) - CHARINDEX('\', REVERSE(@FullName)));
         RETURN @result;
     END; 
GO
IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'PathfFilename')
          AND type IN(N'FN', N'IF', N'TF', N'FS', N'FT')
)
    DROP FUNCTION PathfFilename;
GO

/*   HOW TO USE: 
SELECT dbo.PathfFilename('C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2\MSSQL\Log\system_health_0_131996396680890000.xel') 
*/

CREATE FUNCTION dbo.PathfFilename
(@FullName VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
     BEGIN
         DECLARE @FindChar VARCHAR(1)= '\';
         DECLARE @result VARCHAR(500)= '';
         IF(dbo.Isfullpath(@FullName) = 1)
             SET @result =
             (
                 SELECT RIGHT(@FullName, CHARINDEX(@FindChar, REVERSE(@FullName)) - 1)
             );
         RETURN @result;
     END; 
GO