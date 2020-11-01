
IF EXISTS (SELECT * 
       FROM   sysobjects 
           WHERE name='LastIndexOf' and xtype in ('FN', 'TF'))
		   drop function LastIndexOf
go
CREATE FUNCTION dbo.LastIndexOf(@source nvarchar(4000), @pattern char)
RETURNS int
BEGIN  
       RETURN (LEN(@source)) -  CHARINDEX(@pattern, REVERSE(@source)) 
END;  
GO

IF EXISTS (SELECT * 
       FROM   sysobjects 
           WHERE name='StringBeforeLastIndex' and xtype in ('FN', 'TF'))
		   drop function StringBeforeLastIndex
go
CREATE FUNCTION dbo.StringBeforeLastIndex(@source nvarchar(4000), @pattern char)
RETURNS nvarchar(80)
BEGIN  
       DECLARE @lastIndex int
       SET @lastIndex = (LEN(@source)) -  CHARINDEX(@pattern, REVERSE(@source)) 

     RETURN SUBSTRING(@source, 0, @lastindex + 1) 
     -- +1 because index starts at 0, but length at 1, so to get up to 11th index, we need LENGTH 11+1=12
END;  
GO