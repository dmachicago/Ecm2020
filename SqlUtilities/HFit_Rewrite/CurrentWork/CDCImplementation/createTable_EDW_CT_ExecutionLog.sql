
GO
PRINT 'Creating Table EDW_CT_ExecutionLog';
PRINT 'FROM: createTable_EDW_CT_ExecutionLog.sql';
GO
--drop table EDW_CT_ExecutionLog

/*---------------------------------------------------------
alter table EDW_CT_ExecutionLog add CT_Inserts bigint NULL
alter table EDW_CT_ExecutionLog add CT_Updates bigint NULL
alter table EDW_CT_ExecutionLog add CT_Deletes bigint NULL	
*/

SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.tables
                       WHERE
                       name = 'EDW_CT_ExecutionLog') 
    BEGIN

        CREATE TABLE dbo.EDW_CT_ExecutionLog (
                     CT_NAME NVARCHAR ( 80) NOT NULL
                   , CT_Start DATETIME NOT NULL
                   , CT_End DATETIME NULL
                   , CT_TotalMinutes INT NULL
                   , CT_RecordsProcessed BIGINT NULL
                   , CT_Inserts BIGINT NULL
                   , CT_Updates BIGINT NULL
                   , CT_Deletes BIGINT NULL
                   , RecordID UNIQUEIDENTIFIER NOT NULL
                   , CONSTRAINT PK_EDW_CT_ExecutionLog PRIMARY KEY CLUSTERED ( RecordID ASC)) ;

        ALTER TABLE dbo.EDW_CT_ExecutionLog
        ADD
                    CONSTRAINT DF_EDW_CT_ExecutionLog_RecordID DEFAULT NEWID () FOR RecordID;
        EXEC proc_Add_EDW_CT_StdCols EDW_CT_ExecutionLog;
    END;
ELSE
    BEGIN
        IF NOT EXISTS ( SELECT
                               column_name
                               FROM information_schema.columns
                               WHERE
                               column_name = 'CT_Inserts' AND
                               table_name = 'EDW_CT_ExecutionLog') 
            BEGIN
                ALTER TABLE EDW_CT_ExecutionLog
                ADD
                            CT_Inserts BIGINT NULL;
            END;
        IF NOT EXISTS ( SELECT
                               column_name
                               FROM information_schema.columns
                               WHERE
                               column_name = 'CT_Updates' AND
                               table_name = 'EDW_CT_ExecutionLog') 
            BEGIN
                ALTER TABLE EDW_CT_ExecutionLog
                ADD
                            CT_Updates BIGINT NULL;
            END;
        IF NOT EXISTS ( SELECT
                               column_name
                               FROM information_schema.columns
                               WHERE
                               column_name = 'CT_Deletes' AND
                               table_name = 'EDW_CT_ExecutionLog') 
            BEGIN
                ALTER TABLE EDW_CT_ExecutionLog
                ADD
                            CT_Deletes BIGINT NULL;
            END;
    END;
GO

PRINT 'CREATED Table EDW_CT_ExecutionLog';
GO

PRINT 'CREATING PROC proc_EDW_CT_ExecutionLog_Update';
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE
                   name = 'proc_EDW_CT_ExecutionLog_Update') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_CT_ExecutionLog_Update;
    END;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE
                   name = 'proc_EDW_CT_ExecutionLog_Update_Counts') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_CT_ExecutionLog_Update_Counts;
    END;

GO

CREATE PROCEDURE proc_EDW_CT_ExecutionLog_Update_Counts (
       @RecordID AS UNIQUEIDENTIFIER
     , @TypeAction AS CHAR (1) 
     , @iCnt AS BIGINT = 0) 
AS
BEGIN

/*---------------------------------------------------
    @TypeAction:
    T = Total of processed records.
    I = Update the count of inserted records
    U = Update the count of updated records
    D = Update the count of flaged as deleted records
*/

    IF
       @TypeAction = 'T'
        BEGIN
            DECLARE
                   @TotRecs AS BIGINT = (SELECT
                                                ISNULL (CT_INSERTs , 0) + ISNULL (CT_Updates , 0) + ISNULL (CT_Deletes , 0) 
                                                FROM EDW_CT_ExecutionLog
                                                WHERE
                                                RecordID = @RecordID) ;

            IF @iCnt > 0
                BEGIN
                    PRINT 'Executing Log Update T0 on ' + CAST (@iCnt AS NVARCHAR (50)) + ' records.';
                    UPDATE dbo.EDW_CT_ExecutionLog
                      SET
                          CT_RecordsProcessed = @iCnt
                           WHERE
                           RecordID = @RecordID;
                END;
            ELSE
                BEGIN
                    PRINT 'Executing Log Update T1 on ' + CAST (@TotRecs AS NVARCHAR (50)) + ' records.';
                    UPDATE dbo.EDW_CT_ExecutionLog
                      SET
                          CT_RecordsProcessed = @TotRecs
                           WHERE
                           RecordID = @RecordID;
                END;
        END;
    IF
           @TypeAction = 'I'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
              SET
                  CT_Inserts = @iCnt
                   WHERE
                   RecordID = @RecordID;
        END;
    IF
           @TypeAction = 'U'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
              SET
                  CT_Updates = @iCnt
                   WHERE
                   RecordID = @RecordID;
        END;
    IF
           @TypeAction = 'D'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
              SET
                  CT_Deletes = @iCnt
                   WHERE
                   RecordID = @RecordID;
        END;
END;
GO
CREATE PROCEDURE proc_EDW_CT_ExecutionLog_Update (
       @RecordID AS UNIQUEIDENTIFIER
     , @CT_NAME AS NVARCHAR (80) 
     , @CT_DateTimeNow AS DATETIME
     , @CT_RecordsProcessed AS BIGINT = 0
     , @Action AS NVARCHAR (5)) 
AS
BEGIN
    IF @Action = 'I'
        BEGIN
            INSERT INTO dbo.EDW_CT_ExecutionLog (
                   CT_NAME
                 , CT_Start
                 , CT_End
                 , CT_TotalMinutes
                 , CT_RecordsProcessed
                 , RecordID) 
            VALUES
            (
            @CT_NAME , @CT_DateTimeNow , NULL , NULL , NULL , @RecordID) ;
        END;
    IF @Action = 'U'
        BEGIN
            --declare @STime as datetime = getdate() -1 ;
            --declare @CT_DateTimeNow as datetime = getdate();
            --select DATEDIFF (MINUTE, @STime , @CT_DateTimeNow);
            DECLARE
                   @STime AS DATETIME = ( SELECT
                                                 CT_Start
                                                 FROM EDW_CT_ExecutionLog
                                                 WHERE
                                                 RecordID = @RecordID) ;

            PRINT '@Stime = ' + CAST ( @Stime AS NVARCHAR ( 50)) ;
            DECLARE
                   @Mins AS INT = DATEDIFF ( MINUTE , @STime , @CT_DateTimeNow) ;
            PRINT '@Mins = ' + CAST ( @Mins AS NVARCHAR ( 50)) ;
            UPDATE dbo.EDW_CT_ExecutionLog
              SET
                  CT_End = @CT_DateTimeNow
                ,CT_TotalMinutes = DATEDIFF ( MINUTE , @STime , @CT_DateTimeNow) 
                ,CT_RecordsProcessed = @CT_RecordsProcessed
                   WHERE
                   RecordID = @RecordID;

        END;

END;

GO
PRINT 'CREATED PROC proc_EDW_CT_ExecutionLog_Update';
GO

--Test the PROC

/*---------------------------------------------------------------------------------------------------
declare @RecordID AS uniqueidentifier = newid();
declare @CT_NAME as nvarchar(50) = 'TESTRUN' ;
declare @CT_DateTimeNow as datetime = getdate() -1 ;
declare @CT_RecordsProcessed as bigint = 0 ; 
declare @Action AS nvarchar (5) = 'I';

exec proc_EDW_CT_ExecutionLog_Update @RecordID, @CT_NAME, @CT_DateTimeNow, @CT_RecordsProcessed, 'I';
select * from EDW_CT_ExecutionLog ;
set @CT_DateTimeNow = getdate() ;
set @CT_RecordsProcessed = 9999;
exec proc_EDW_CT_ExecutionLog_Update @RecordID, @CT_NAME, @CT_DateTimeNow, @CT_RecordsProcessed, 'U';
select * from EDW_CT_ExecutionLog ;
truncate table EDW_CT_ExecutionLog;
*/