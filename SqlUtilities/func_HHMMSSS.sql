
GO

PRINT 'Executing func_HHMMSSS.SQL';

GO

IF EXISTS (SELECT
                  *
                  FROM   sys.objects
                  WHERE  object_id = OBJECT_ID (N'[dbo].[func_HHMMSSS]') 
                     AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT')) 
    BEGIN
        DROP FUNCTION
             dbo.func_HHMMSSS;
    END;
GO

CREATE FUNCTION dbo.func_HHMMSSS (
     @st datetime
) 
RETURNS nvarchar (25) 
AS
BEGIN
    DECLARE @rettime AS nvarchar (50) = '';
    DECLARE @dt2 datetime = GETDATE () ;

    SET @rettime = (SELECT
                           CONVERT (varchar (12) , DATEADD (ms, DATEDIFF (ms, @st, @dt2) , 0) , 114) );

    RETURN @rettime;
END;
GO

PRINT 'Executed func_HHMMSSS.SQL';

GO

/*--------------------------------------------------------
declare @ret as nvarchar(50) = '' ;
declare @dt as datetime = cast('2015-08-02' as datetime) ;

EXEC @ret = dbo.func_HHMMSSS @dt ;
print @ret ;

OR 

declare @dt as datetime = cast('2015-08-02' as datetime) ;
print dbo.func_HHMMSSS @dt ;
*/
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
