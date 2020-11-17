

go
print 'Executing proc_EDW_CT_ExecutionLog_Update.sql'
go
if exists (select name from sys.procedures where name = 'proc_EDW_CT_ExecutionLog_Update')
    DROP PROCEDURE [dbo].[proc_EDW_CT_ExecutionLog_Update]
GO

CREATE PROCEDURE [dbo].[proc_EDW_CT_ExecutionLog_Update] (
       @RecordID AS uniqueidentifier
     , @CT_NAME AS nvarchar (80) 
     , @CT_DateTimeNow AS datetime
     , @CT_RecordsProcessed AS bigint = 0
     , @Action AS nvarchar (5)) 
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
                   @STime AS datetime = ( SELECT
                                                 CT_Start
                                                 FROM EDW_CT_ExecutionLog
                                                 WHERE RecordID = @RecordID );

            PRINT '@Stime = ' + CAST ( @Stime AS nvarchar ( 50)) ;
            DECLARE
                   @Mins AS int = DATEDIFF ( MINUTE , @STime , @CT_DateTimeNow) ;
            PRINT '@Mins = ' + CAST ( @Mins AS nvarchar ( 50)) ;
            UPDATE dbo.EDW_CT_ExecutionLog
                   SET
                       CT_End = @CT_DateTimeNow
                     ,CT_TotalMinutes = DATEDIFF ( MINUTE , @STime , @CT_DateTimeNow) 
                     ,CT_RecordsProcessed = @CT_RecordsProcessed
            WHERE
                  RecordID = @RecordID;

        END;

END;


go
print 'Executed proc_EDW_CT_ExecutionLog_Update.sql'
go
