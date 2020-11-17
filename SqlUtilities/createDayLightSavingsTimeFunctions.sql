
GO
PRINT 'FROM: createDayLightSavingsTimeFunctions.sql';

GO
IF EXISTS ( SELECT
                   *
                   FROM    dbo.sysobjects
                   WHERE
                   id = OBJECT_ID (N'[dbo].[udfGetDstStart]') 
               AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT')) 
    BEGIN
        PRINT 'Replacing udfGetDstStart';
        DROP FUNCTION
             udfGetDstStart;
    END;

GO

CREATE FUNCTION udfGetDstStart (
     @Year AS int) 
RETURNS datetime
AS
--Author: W. Dale Miller
--Date  : Jan 15, 2009
BEGIN
    DECLARE
    @StartOfMarch datetime
  ,@DstStart datetime;

    SET @StartOfMarch = DATEADD (MONTH, 2,
    DATEADD (YEAR, @year - 1900, 0)) ;
    SET @DstStart = DATEADD (HOUR, 2,
    DATEADD (day, ( 15 - DATEPART (dw,
                    @StartOfMarch) ) % 7 + 7, @StartOfMarch)) ;
    RETURN @DstStart;
END;

GO
IF EXISTS ( SELECT
                   *
                   FROM    dbo.sysobjects
                   WHERE
                   id = OBJECT_ID (N'[dbo].[udfGetDstEnd]') 
               AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT')) 
    BEGIN
        PRINT 'Replacing udfGetDstEnd';
        DROP FUNCTION
             dbo.udfGetDstEnd;
    END;
GO
CREATE FUNCTION dbo.udfGetDstEnd (
     @Year AS int) 
RETURNS datetime
AS
--Author: W. Dale Miller
--Date  : Jan 15, 2009
BEGIN
    DECLARE
    @StartOfNovember datetime
  ,@DstEnd datetime;

    SET @StartOfNovember = DATEADD (MONTH, 10,
    DATEADD (YEAR, @year - 1900, 0)) ;
    SET @DstEnd = DATEADD (HOUR, 2,
    DATEADD (day,
    ( 8 - DATEPART (dw,
      @StartOfNovember) ) % 7, @StartOfNovember)) ;
    RETURN @DstEnd;
END;

GO


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
