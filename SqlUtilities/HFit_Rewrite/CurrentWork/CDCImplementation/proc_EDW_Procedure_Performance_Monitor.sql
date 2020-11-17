
GO
PRINT 'Creating PROC proc_EDW_Procedure_Performance_Monitor.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EDW_Procedure_Performance_Monitor') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_Procedure_Performance_Monitor;
    END;
GO

CREATE PROCEDURE proc_EDW_Procedure_Performance_Monitor
       @Action AS CHAR (1) = 'I'
     , @TraceName NVARCHAR (100) 
     , @TrackID AS NVARCHAR (50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

/*---------------------------------------------------------------------------------------------
I = insert new record
E = add enddate to specified record by TraceName and TrackID
D = delete all occurances of records by TraceName
T = total the elapsed and accumulated time for the specified TraceName

select * from EDW_Proc_Performance_Monitor where TraceName = 'proc_Staging_EDW_Data' order by RowNbr
exec proc_EDW_Procedure_Performance_Monitor 'D', 'proc_Staging_EDW_Data'
exec proc_EDW_Procedure_Performance_Monitor 'I', 'TestRun', '001'
exec proc_EDW_Procedure_Performance_Monitor 'I', 'TestRun', '002'
exec proc_EDW_Procedure_Performance_Monitor 'I', 'TestRun', '003'
exec proc_EDW_Procedure_Performance_Monitor 'I', 'TestRun', '004'
exec proc_EDW_Procedure_Performance_Monitor 'I', 'TestRun', '005'
exec proc_EDW_Procedure_Performance_Monitor 'T', 'proc_Staging_EDW_Data'

update EDW_Proc_Performance_Monitor set ElapsedSecs = cast(ElapsedTime as float)/ 1000 
update EDW_Proc_Performance_Monitor set ElapsedMin = cast(ElapsedTime as float) / 1000 / 60 
update EDW_Proc_Performance_Monitor set ElapsedHrs = cast(ElapsedTime as float) / 1000 / 60 /60
*/
    DECLARE
           @TimeNow AS DATETIME2 = GETDATE () ;

    IF @TrackID IS NULL
        BEGIN
            SET @TrackID = CAST (@TimeNow AS NVARCHAR (50)) 
        END;

    IF @Action = 'D'
        BEGIN
            DELETE FROM EDW_Proc_Performance_Monitor
                   WHERE
                         TraceName = @TraceName;
            RETURN;
        END;

    IF @Action = 'I'
        BEGIN
            INSERT INTO dbo.EDW_Proc_Performance_Monitor
            (
                   TraceName
                 , TrackID
                 , StartTime
                 , EndTime
                 , ElapsedTime
                 , ElapsedTimeUnits) 
            VALUES
            (
            @TraceName
            , @TrackID
            , @TimeNow
            , NULL
            , NULL
            , 'ms') ;
        END;
    IF @Action = 'E'
        BEGIN
            DECLARE
                   @sd AS DATETIME = (SELECT
                                             StartTime
                                             FROM EDW_Proc_Performance_Monitor
                                             WHERE
                                             TraceName = @TraceName AND
                                             TrackID = @TrackID) ;
            DECLARE
                   @Dstring AS NVARCHAR (50) = CAST (@sd AS NVARCHAR (50)) ;
            DECLARE
                   @ms AS INT = DATEDIFF (millisecond , @Dstring , @Dstring) ;

            UPDATE dbo.EDW_Proc_Performance_Monitor
              SET
                  EndTime = GETDATE () 
                ,ElapsedTime = @ms
                   WHERE
                         TraceName = @TraceName AND
                         TrackID = @TrackID;
        END;
    IF @Action = 'T'
        BEGIN

            DECLARE
                   @ST AS DATETIME2 (7) = NULL;
            DECLARE
                   @ET AS DATETIME2 (7) = NULL;
            DECLARE
                   @ElapsedTime AS INT = 0;
            DECLARE
                   @RN AS INT = 0;
            DECLARE
                   @PrevRN AS INT = 0;
            DECLARE
                   @i AS INT = 0;
            DECLARE
                   @initTime AS DATETIME2 = NULL;
            DECLARE
                   @accumTime AS INT = 0;

            SET @ElapsedTime = DATEDIFF (microsecond , @ET , @ST) ;
            PRINT @ElapsedTime;

            DECLARE db_cursor CURSOR
                FOR
                    SELECT
                           TraceName
                         , RowNbr
                         , StartTime
                           FROM dbo.EDW_Proc_Performance_Monitor
                           WHERE TraceName = @TraceName
                           ORDER BY
                                    RowNbr;

            OPEN db_cursor;
            FETCH NEXT FROM db_cursor INTO @TraceName , @RN , @ST;

            WHILE @@FETCH_STATUS = 0
                BEGIN
                    SET @ST = (SELECT
                                      StartTime
                                      FROM EDW_Proc_Performance_Monitor
                                      WHERE RowNbr = @RN) ;
                    SET @PrevRN = (SELECT
                                          MAX (Rownbr) 
                                          FROM EDW_Proc_Performance_Monitor
                                          WHERE RowNbr < @RN) ;
                    SET @ET = (SELECT
                                      StartTime
                                      FROM EDW_Proc_Performance_Monitor
                                      WHERE RowNbr = @PrevRN) ;

                    IF @i = 0
                        BEGIN
                            SET @initTime = @ST;
                            SET @accumTime = 0;
                            SET @ElapsedTime = 0;
                        END;
                    ELSE
                        BEGIN
                            SET @ElapsedTime = DATEDIFF (MILLISECOND , @ET , @ST) ;
                            SET @accumTime = DATEDIFF (MILLISECOND , @initTime , @ST) ;
                        END;

                    --if @i > 100 and @i < 150 
                    --print @RN, @PrevRN, @ET, @accumTime ;

                    UPDATE dbo.EDW_Proc_Performance_Monitor
                      SET
                          ElapsedTime = @ElapsedTime
                        ,AccumulatedTime = @accumTime
                        ,ElapsedSecs = CAST (@ElapsedTime AS FLOAT) / 1000
                        ,ElapsedMin = CAST (@ElapsedTime AS FLOAT) / 1000 / 60
                        ,ElapsedHrs = CAST (@ElapsedTime AS FLOAT) / 1000 / 60 / 60
                           WHERE
                                 RowNbr = @RN;
                    SET @i = @i + 1;
                    FETCH NEXT FROM db_cursor INTO @TraceName , @RN , @ST;
                END;

            CLOSE db_cursor;
            DEALLOCATE db_cursor;
        END;

END;  --Procedure

GO
PRINT 'Created PROC proc_EDW_Procedure_Performance_Monitor.sql';
GO
