

GO
PRINT 'Creating proc_CT_Performance_History';
PRINT 'FROM proc_CT_Performance_History.sql';
GO

IF EXISTS (SELECT
              name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_Performance_History') 
    BEGIN
        DROP PROCEDURE
           proc_CT_Performance_History;
    END;
GO

/*
Author: W. Dale Miller
Created: 05.06.2015
Purpose: Track ongoing performance of selected procs and functions

exec proc_CT_Performance_History @RowGuid, @CALLING_PROC, @PROC_LOCATION, @starttime, @endtime, @elapsedsecs, @RowsProcessed ;

*/

CREATE PROCEDURE proc_CT_Performance_History
       @RowGuid AS uniqueidentifier
     , @CALLING_PROC AS nvarchar (100) 
     , @PROC_LOCATION AS nvarchar (100) 
     , @starttime AS datetime2 = NULL
     , @endtime  AS datetime2 = NULL
     , @elapsedsecs AS bigint = NULL
     , @RowsProcessed AS bigint = NULL
AS
BEGIN

    DECLARE @iCnt AS int = 0
          , @elapsedmin AS decimal (10, 2) 
          , @elapsedhr AS decimal (10, 2) ;

    SET @iCnt = (SELECT
                    COUNT (*) 
                        FROM CT_Performance_History
                        WHERE RowGuid = @RowGuid );

    IF @iCnt = 0
        BEGIN
            IF @starttime IS NULL
                BEGIN
                    SET @starttime = GETDATE () ;
                END;

            INSERT INTO dbo.CT_Performance_History
            (
               RowGuid
             , CALLING_PROC
             , PROC_LOCATION
             , starttime
             , endtime
             , elapsedsecs
             , elapsedmin
             , elapsedhr
             , RowsProcessed
             , CreateDate
             , LastModifiedDate) 
            VALUES
                   (
                   @RowGuid
                   , @CALLING_PROC
                   , @PROC_LOCATION
                   , @starttime
                   , @endtime
                   , @elapsedsecs
                   , @elapsedmin
                   , @elapsedhr
                   , @RowsProcessed
                   , GETDATE () 
                   , GETDATE ()) ;
        END;

    --IF @starttime IS NOT NULL
    --        BEGIN
    --            UPDATE CT_Performance_History
    --                   SET
    --               starttime = @starttime;
    --        END;
    IF @endtime IS NOT NULL
        BEGIN
            UPDATE CT_Performance_History
                   SET
               endtime = @endtime
            WHERE
               RowGuid = @RowGuid;
        END;
    IF
           @endtime IS NOT NULL
       AND @starttime IS NOT NULL
        BEGIN
            SET @elapsedsecs = DATEDIFF ( second , @starttime , @endtime) ;

            UPDATE CT_Performance_History
                   SET
               elapsedsecs = @elapsedsecs
            WHERE
               RowGuid = @RowGuid;
        END;
    IF @elapsedsecs IS NOT NULL
        BEGIN
            UPDATE CT_Performance_History
                   SET
               elapsedsecs = @elapsedsecs
            WHERE
               RowGuid = @RowGuid;
            DECLARE @m AS decimal (10, 2) = @elapsedsecs / 60;
            UPDATE CT_Performance_History
                   SET
               elapsedmin = @m
            WHERE
               RowGuid = @RowGuid;
            DECLARE @h AS decimal (10, 2) = @m / 60;
            UPDATE CT_Performance_History
                   SET
               elapsedhr = @h
            WHERE
               RowGuid = @RowGuid;
        END;
    IF @RowsProcessed IS NOT NULL
        BEGIN
            UPDATE CT_Performance_History
                   SET
               RowsProcessed = @RowsProcessed
            WHERE
               RowGuid = @RowGuid;
        END;
    UPDATE CT_Performance_History
           SET
       LastModifiedDate = GETDATE () 
    WHERE
       RowGuid = @RowGuid;

END;

GO
PRINT 'Created proc_CT_Performance_History';
PRINT 'FROM proc_CT_Performance_History.sql';
GO
