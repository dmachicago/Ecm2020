
IF OBJECT_ID (N'dbo.strClean', N'FN') IS NOT NULL  
    DROP FUNCTION DBO.strClean;  
GO  
CREATE FUNCTION DBO.strClean(@str nvarchar(2000))  
RETURNS nvarchar  (max) 
AS   
-- converts delimites to blanks 
BEGIN  
    set @str = REPLACE(@str,',',' ');  
	set @str = REPLACE(@str,';',' ');  
	set @str = REPLACE(@str,':',' ');  
	set @str = REPLACE(@str,'.',' ');  
	RETURN @str;  
END; 

go
--=====================================================
declare @str nvarchar (500) ='this     is the, end of :THE:WORLD';
set @str = (select DBO.strClean ( @str ));
print @str ;

DECLARE @SearchText NVARCHAR(2000)
SET @SearchText = ''

SELECT @SearchText = @SearchText + value + ' AND '
FROM STRING_SPLIT(@str, ' ')  
WHERE RTRIM(value) <> '';  

print @SearchText ;

IF OBJECT_ID (N'dbo.strClean', N'FN') IS NOT NULL  
    DROP FUNCTION DBO.strClean;  
GO  
CREATE FUNCTION DBO.strClean(@str nvarchar(2000))  
RETURNS nvarchar  (max) 
AS   
-- converts delimites to blanks 
BEGIN  
    set @str = REPLACE(@str,',',' ');  
	set @str = REPLACE(@str,';',' ');  
	set @str = REPLACE(@str,':',' ');  
	set @str = REPLACE(@str,'.',' ');  
	RETURN @str;  
END; 

go

IF OBJECT_ID (N'dbo.strPack', N'FN') IS NOT NULL  
    DROP FUNCTION strPack;  
GO  
CREATE FUNCTION dbo.strPack(@str nvarchar(2000))  
RETURNS nvarchar   
AS   
-- removes duplicate blanks  
BEGIN  
    declare @test varchar(100)
	while charindex('  ',@str  ) > 0
	begin
		set @test = replace(@str, '  ', ' ')
	end
	RETURN @str;  
END; 

go

IF OBJECT_ID (N'dbo.strSplitAnd', N'FN') IS NOT NULL  
    DROP FUNCTION dbo.strSplitAnd;  
GO  
CREATE FUNCTION dbo.strSplitAnd(@str nvarchar(2000))  
RETURNS nvarchar   
AS   
-- replaces blanks with AND.  
BEGIN  
    set @str = REPLACE(@str,' ',' AND ');  
	RETURN @str;  
END; 
go

--*******************************************
IF OBJECT_ID (N'escapeFTSSearch', N'FN') IS NOT NULL  
    DROP FUNCTION escapeFTSSearch;  
GO  

create FUNCTION [dbo].[escapeFTSSearch] (
  @SearchParameter NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
  -- Declare the return variable here
  DECLARE @result NVARCHAR(MAX)
  SELECT @result = '"'+ REPLACE(REPLACE(@SearchParameter,'"',''), ' ', '" AND "') +'"' ;
  SELECT @result = '"'+ REPLACE(REPLACE(@result,'"',''), ' ', '" AND "') +'"' ;

  -- Return the result of the function
  RETURN @result

END
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
