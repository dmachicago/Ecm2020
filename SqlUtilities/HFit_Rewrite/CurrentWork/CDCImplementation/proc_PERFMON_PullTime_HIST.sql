GO
PRINT 'EXecuting proc_PERFMON_PullTime_HIST.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_PERFMON_PullTime_HIST') 
    BEGIN
        DROP PROCEDURE
             proc_PERFMON_PullTime_HIST;
    END;
GO

/*-----------------------------------------------------------------------
declare @RowGuid as nvarchar(100) = cast(newid() as nvarchar(50)) ;
declare @Action AS nvarchar (10) = 'T' ;
declare @DBMS nvarchar (100) = 'XXX' ; 
declare @TblName nvarchar (100) = 'TEST_TABLE';
declare @NbrRecs AS int = 100 ;

set @RowGuid = '7DA6A53A-C98E-40F9-B6E3-DE484AF6B9D3' ;

exec proc_PERFMON_PullTime_HIST @RowGuid, @Action, @DBMS, @TblName, @NbrRecs

select * from  dbo.PERFMON_PullTime_HIST order by ProcName, TblName, DBMS
*/
CREATE PROCEDURE proc_PERFMON_PullTime_HIST (
     @RowGuid AS nvarchar (100) 
   , @Action AS nvarchar (10) 
   , @DBMS nvarchar (100) 
   , @TblName nvarchar (100) 
   , @NbrRecs AS int = NULL
   , @ProcName AS nvarchar (100)) 
AS
BEGIN

    --@Action : N - add a new record to the PERFMON_PullTime_HIST table
    --		 IS - add the Insert Start Time
    --		 IE - add the Insert END Time and the NbrRecs inserted
    --		 US - add the Update Start Time
    --		 UE - add the Update END Time and the NbrRecs updated
    --		 DS - add the Delete Start Time
    --		 DE - add the Delete END Time and the NbrRecs deleted
    --		 T -  Calculate the total elapsed time for the PULL in minutes

    IF @Action = 'T'
        BEGIN
            DECLARE
            @S AS datetime = ( SELECT
                                      ExecutionStartTime
                                      FROM  PERFMON_PullTime_HIST
                                      WHERE
                                      RowGuid = @RowGuid );
            DECLARE
            @MS AS float = DATEDIFF ( SECOND , @S , GETDATE ()) ;
            PRINT '@Seconds: ' + CAST (@ms AS nvarchar (50)) ;
            DECLARE
            @ET AS float = @ms / 60;
            PRINT '@ET: ' + CAST (@ET AS nvarchar (50)) ;
            UPDATE dbo.PERFMON_PullTime_HIST
                   SET
                       ExecutionEndDate = GETDATE () 
                     ,TotalTimeMinutes = @ET
            WHERE
                  RowGuid = @RowGuid;
        END;
    IF @Action = 'N'
        BEGIN
            INSERT INTO dbo.PERFMON_PullTime_HIST
            (
                   RowGuid
                 , DBMS
                 , TblName
                 , ExecutionStartTime
                 , ProcName
            ) 
            VALUES
                   (
                   @RowGuid
                   , @DBMS
                   , @TblName
                   , GETDATE () , @ProcName) ;
        END;
    IF @Action = 'IS'
        BEGIN
            UPDATE dbo.PERFMON_PullTime_HIST
                   SET
                       InsertStartTime = GETDATE () 
            WHERE
                  RowGuid = @RowGuid;
        END;
    IF @Action = 'IE'
        BEGIN
            UPDATE dbo.PERFMON_PullTime_HIST
                   SET
                       InsertEndTime = GETDATE () 
                     ,InsertCount = @NbrRecs
            WHERE
                  RowGuid = @RowGuid;
        END;
    IF @Action = 'US'
        BEGIN
            UPDATE dbo.PERFMON_PullTime_HIST
                   SET
                       UpdateStartTime = GETDATE () 
            WHERE
                  RowGuid = @RowGuid;
        END;
    IF @Action = 'UE'
        BEGIN
            UPDATE dbo.PERFMON_PullTime_HIST
                   SET
                       UpdateEndTime = GETDATE () 
                     ,UpdateCount = @NbrRecs
            WHERE
                  RowGuid = @RowGuid;
        END;
    IF @Action = 'DS'
        BEGIN
            UPDATE dbo.PERFMON_PullTime_HIST
                   SET
                       DeleteStartTime = GETDATE () 
            WHERE
                  RowGuid = @RowGuid;
        END;
    IF @Action = 'DE'
        BEGIN
            UPDATE dbo.PERFMON_PullTime_HIST
                   SET
                       DeleteEndTime = GETDATE () 
                     ,DeleteCount = @NbrRecs
            WHERE
                  RowGuid = @RowGuid;
        END;
END;
GO
PRINT 'Executed proc_PERFMON_PullTime_HIST.sql';
GO