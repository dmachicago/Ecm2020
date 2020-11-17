

GO
PRINT 'EXecuting proc_EDW_CT_ExecutionLog_Update_Counts.sql';
GO
IF EXISTS (SELECT name
                  FROM sys.procedures
                  WHERE name = 'proc_EDW_CT_ExecutionLog_Update_Counts') 
    BEGIN
        DROP PROCEDURE dbo.proc_EDW_CT_ExecutionLog_Update_Counts
    END;
GO

CREATE PROCEDURE dbo.proc_EDW_CT_ExecutionLog_Update_Counts (
     @RecordID AS uniqueidentifier
     , @TypeAction AS char (1) 
     , @iCnt AS bigint = 0) 
AS
BEGIN

/*
    @TypeAction:
    T = Total of processed records.
    I = Update the count of inserted records
    U = Update the count of updated records
    D = Update the count of flaged as deleted records
    */

    IF @TypeAction = 'T'
        BEGIN
            DECLARE
            @TotRecs AS bigint = (SELECT
                                  ISNULL (CT_INSERTs, 0) + ISNULL (CT_Updates, 0) + ISNULL (CT_Deletes, 0) 
                                         FROM EDW_CT_ExecutionLog
                                         WHERE RecordID = @RecordID);

            IF @iCnt > 0
                BEGIN
                    PRINT 'Executing Log Update T0 on ' + CAST (@iCnt AS nvarchar (50)) + ' records.';
                    UPDATE dbo.EDW_CT_ExecutionLog
                           SET
                    CT_RecordsProcessed = @iCnt
                    WHERE
                    RecordID = @RecordID;
                END;
            ELSE
                BEGIN
                    PRINT 'Executing Log Update T1 on ' + CAST (@TotRecs AS nvarchar (50)) + ' records.';
                    UPDATE dbo.EDW_CT_ExecutionLog
                           SET
                    CT_RecordsProcessed = @TotRecs
                    WHERE
                    RecordID = @RecordID;
                END;
        END;
    IF @TypeAction = 'I'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
                   SET
            CT_Inserts = @iCnt
            WHERE
            RecordID = @RecordID;
        END;
    IF @TypeAction = 'U'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
                   SET
            CT_Updates = @iCnt
            WHERE
            RecordID = @RecordID;
        END;
    IF @TypeAction = 'D'
        BEGIN
            UPDATE dbo.EDW_CT_ExecutionLog
                   SET
            CT_Deletes = @iCnt
            WHERE
            RecordID = @RecordID;
        END;
END;

GO
PRINT 'EXecuted proc_EDW_CT_ExecutionLog_Update_Counts.sql';
GO
