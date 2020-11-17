
/*
DECLARE @result VARCHAR(1000) ;
EXEC GenWhereInClause 'wmiller', 'C:\Users\wmiller\Desktop\Documents', @result OUTPUT
print @result  ;
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'GenWhereInClause'
)
    DROP PROCEDURE GenWhereInClause;
GO
CREATE PROCEDURE GenWhereInClause
(@UserID VARCHAR(50), 
 @DIR    NVARCHAR(1000), 
 @result NVARCHAR(1000) OUT
)
AS
    BEGIN
        DECLARE @r NVARCHAR(1000)= '';
        SELECT @r = +@r + N'''' + Extcode + N''','
        FROM IncludedFiles
        WHERE UserID = @UserID
              AND fqn = @DIR;
        SET @result = '(' + @r + ')';
    END;