
IF EXISTS
(
    SELECT *
    FROM sysobjects
    WHERE name = 'LastIndexOf'
          AND xtype IN('FN', 'TF')
)
    DROP FUNCTION LastIndexOf;
GO
CREATE FUNCTION dbo.LastIndexOf
(@source  NVARCHAR(4000), 
 @pattern CHAR
)
RETURNS INT
     BEGIN
         RETURN(LEN(@source)) - CHARINDEX(@pattern, REVERSE(@source));
     END;  
GO
IF EXISTS
(
    SELECT *
    FROM sysobjects
    WHERE name = 'StringBeforeLastIndex'
          AND xtype IN('FN', 'TF')
)
    DROP FUNCTION StringBeforeLastIndex;
GO
CREATE FUNCTION dbo.StringBeforeLastIndex
(@source  NVARCHAR(4000), 
 @pattern CHAR
)
RETURNS NVARCHAR(80)
     BEGIN
         DECLARE @lastIndex INT;
         SET @lastIndex = (LEN(@source)) - CHARINDEX(@pattern, REVERSE(@source));
         RETURN SUBSTRING(@source, 0, @lastindex + 1); 
         -- +1 because index starts at 0, but length at 1, so to get up to 11th index, we need LENGTH 11+1=12
     END;  
GO