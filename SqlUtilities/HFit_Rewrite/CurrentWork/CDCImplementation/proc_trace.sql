
GO
PRINT 'EXecuting proc_trace.SQL';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_trace') 
    BEGIN
        DROP PROCEDURE
             proc_trace
    END;

GO

CREATE PROCEDURE proc_trace (
     @Msg nvarchar (500) 
   , @StartTime datetime
   , @EndTime datetime) 
AS
BEGIN

    DECLARE @rettime AS nvarchar (50) = '';
    DECLARE @dt2 datetime = GETDATE () ;

    IF @EndTime IS NOT NULL
        BEGIN
            SET @rettime = 'Duration: ' + (SELECT
                                                  CONVERT (varchar (12) , DATEADD (ms, DATEDIFF (ms, @StartTime, @EndTime) , 0) , 114) );
        END
    ELSE
        BEGIN
            SET @rettime = 'Start: ' + CAST (@StartTime AS nvarchar (50)) ;
        END;

    IF @EndTime IS NOT NULL
        BEGIN
            SET @Msg = CHAR (10) + @Msg + ' - ' + @rettime ;
        END
    ELSE
        BEGIN
            SET @Msg = @Msg + ' - ' + @rettime + CHAR (10) ;
        END;
    PRINT @Msg;
END;

GO
EXEC proc_trace 'Test Message', '2015-08-03 11:30:22.722', '2015-08-03 12:27:24.413';
GO
PRINT 'Ececuted proc_trace.SQL';
GO
