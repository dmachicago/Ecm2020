USE [DataMartPlatform];
GO

DECLARE
       @tbl nvarchar (254) = 'BASE_HFit_HealthAssesmentUserAnswers';
SET NOCOUNT ON;
SET ROWCOUNT 250000;
DECLARE
       @iCnt int = 0
     , @iRows int = 0
     , @msg nvarchar (1000) = ''
     , @dbx nvarchar (250) = ''
     , @dbxnew nvarchar (250) = '';

EXEC @iCnt = proc_QuickRowCount @tbl;

--select top 10 * from BASE_HFit_HealthAssesmentUserAnswers

SET @dbx = 'KenticoCMS_1';
SET @dbxnew = 'KenticoCMS_PRD_1';

WHILE 1 = 1
    BEGIN
        SET @msg = @dbx + ' Total Rows: ' + CAST (@iCnt AS nvarchar (50)) + ' : Remaining to process: ' + CAST (@iRows AS nvarchar (50)) + ' @ ' + CAST (GETDATE () AS nvarchar (50)) ;
        EXEC printImmediate @msg;
        BEGIN TRAN;
        UPDATE BASE_HFit_HealthAssesmentUserAnswers
          SET DBNAME = @dbxnew
        WHERE DBNAME = @dbx;
        IF @@ROWCOUNT = 0
            BEGIN
                COMMIT TRANSACTION;
                SET @iRows = @iRows + @@ROWCOUNT;
                BREAK;
            END;
        COMMIT TRAN;
        SET @iRows = @iRows + 100000;
    END;

SET @dbx = 'KenticoCMS_2';
SET @dbxnew = 'KenticoCMS_PRD_2';

WHILE 1 = 1
    BEGIN
        SET @msg = @dbx + ' Total Rows: ' + CAST (@iCnt AS nvarchar (50)) + ' : Remaining to process: ' + CAST (@iRows AS nvarchar (50)) + ' @ ' + CAST (GETDATE () AS nvarchar (50)) ;
        EXEC printImmediate @msg;
        BEGIN TRAN;
        UPDATE BASE_HFit_HealthAssesmentUserAnswers
          SET DBNAME = @dbx
        WHERE DBNAME = @dbx;
        IF @@ROWCOUNT = 0
            BEGIN
                COMMIT TRANSACTION;
                SET @iRows = @iRows + @@ROWCOUNT;
                BREAK;
            END;
        COMMIT TRAN;
        SET @iRows = @iRows + 250000;
    END;

SET @dbx = 'KenticoCMS_3';
SET @dbxnew = 'KenticoCMS_PRD_3';

WHILE 1 = 1
    BEGIN
        SET @msg = @dbx + ' Total Rows: ' + CAST (@iCnt AS nvarchar (50)) + ' : Remaining to process: ' + CAST (@iRows AS nvarchar (50)) + ' @ ' + CAST (GETDATE () AS nvarchar (50)) ;
        EXEC printImmediate @msg;
        BEGIN TRAN;
        UPDATE BASE_HFit_HealthAssesmentUserAnswers
          SET DBNAME = @dbx
        WHERE DBNAME = @dbx;
        IF @@ROWCOUNT = 0
            BEGIN
                COMMIT TRANSACTION;
                SET @iRows = @iRows + @@ROWCOUNT;
                BREAK;
            END;
        COMMIT TRAN;
        SET @iRows = @iRows + 250000;
    END;
--SET ROWCOUNT  0;
SET NOCOUNT OFF;