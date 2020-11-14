
/*
DECLARE @result VARCHAR(1000) ;
EXEC GenWhereInClause 'wmiller', 'C:\dev\ECM2020', @result OUTPUT
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

go

IF EXISTS (SELECT 1 FROM sys.objects 
           WHERE Name = 'udfWhereInClause'
             AND Type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
BEGIN
    PRINT 'User defined function Exists'
	drop function udfWhereInClause
END

/*
DECLARE @result VARCHAR(1000) ;
select udfWhereInClause 'wmiller', 'C:\dev\ECM2020'
print @result  ;
*/
go
Create FUNCTION dbo.udfWhereInClause
(
	@UserID VARCHAR(50), 
	@DIR    NVARCHAR(1000)
)
RETURNS varchar(2000) -- or whatever length you need
AS
BEGIN
    Declare @result varchar(2000);

	BEGIN
        DECLARE @r NVARCHAR(1000)= '';
        SELECT @r = +@r + N'''' + Extcode + N''','
        FROM IncludedFiles
        WHERE UserID = @UserID
              AND fqn = @DIR;
        SET @result = '(' + @r + ')';
    END;

    RETURN  @result

END
GO