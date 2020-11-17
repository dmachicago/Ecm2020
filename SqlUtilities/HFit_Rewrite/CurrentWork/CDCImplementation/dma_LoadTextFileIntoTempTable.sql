
GO
PRINT 'executing dma_LoadTextFileIntoTempTable.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'dma_LoadTextFileIntoTempTable') 
    BEGIN
        DROP PROCEDURE dma_LoadTextFileIntoTempTable;
    END;
GO

/*
USE:
declare @rc int = 0 ; 
declare @RunID nvarchar(80) = '' ;
exec @rc = dma_LoadTextFileIntoTempTable 'X:\FtpDirectory\FTP_File_Name.txt', @RunID output ;
print @RunID ;
print @rc ;
*/

CREATE PROCEDURE dma_LoadTextFileIntoTempTable (@FtpDir nvarchar (500) 
                                              , @FileName nvarchar (500) 
                                              , @RunID nvarchar (100) OUTPUT) 
AS
BEGIN

    DECLARE
           @MySql nvarchar (max) = ''
         , @iCnt int = 0
         , @LastModDate datetime
         , @FileSize int = 0
         , @FQN nvarchar (2000) 
         , @fname nvarchar (2000) 
         , @dir nvarchar (2000) 
         , @msg nvarchar (2000) = '';

    DECLARE
           @DBNAME nvarchar (500) = 'DataMartPlatform'
         , @Schema nvarchar (100) = 'dbo'
           --, @FtpDir  nvarchar(500) = 'Z:\ImportFiles\ClinicalIndicators_Import\Processing'
           --, @FileName  nvarchar(500) = 'rdw_clinicalindicators.2016.11.21.18.55.20.csv'
         , @TgtTBL nvarchar (500) = ''
         , @TruncateTempTable int = 1
         , @PreviewOnly int = 0;

    SET @FQN = @FtpDir + '\' + @FileName;
    SET @FQN = REPLACE (@FQN, '\\', '\') ;
    EXEC dma_GetFileProperties @FQN, @LastModDate OUTPUT, @FileSize OUTPUT, @fname OUTPUT, @dir OUTPUT;
    -- delete from FTP_ProcessStatus where fname like 'rdw%'
    --*************************************************************************
    --** SKIP IF PREVIOUSLY PROCESSED
    SET @iCnt = (SELECT COUNT (*)
                   FROM DataMartPlatform.dbo.FTP_ProcessStatus
                   WHERE Fname = @fname
                     AND ProcessCode = 1) ;
    IF @iCnt > 0
        BEGIN
            SET @msg = 'NOTICE @001: ' + @fname + ' found in FTP_ProcessStatus, appears to have already been processed, SKIPPING... ';
            EXEC printImmediate @msg;
            EXEC ADD_ClinicalIndicators_LOG @msg;
            RETURN;
        END;
    --*************************************************************************

    IF @LastModDate IS NULL
   AND @FileSize IS NULL
        BEGIN
            PRINT 'ERROR: ' + @FQN + ', not found.';
            RETURN -1;
        END;

    --SET @iCnt = (SELECT COUNT (*)
    --               FROM DataMartPlatform.dbo.FTP_Raw_data
    --               WHERE FileName = @fname
    --                 AND CreationDate = @LastModDate) ;

    --IF @iCnt > 0
    --    BEGIN
    --        PRINT 'ERROR: ' + @FQN + ', created on ' + CAST (@LastModDate AS nvarchar (50)) + ', previously processed.';
    --        RETURN -5;
    --    END;

    SET @RunID = CAST (NEWID () AS nvarchar (100)) ;

    --BEGIN TRY
    --    DROP TABLE #TEMP_LINE;
    --END TRY
    --BEGIN CATCH
    --    PRINT 'Creating #TEMP_LINE';
    --END CATCH;

    --CREATE TABLE #TEMP_LINE (line varchar (max) NULL) ;

    DECLARE
           @i int = 0
         , @CorrectedFileName nvarchar (250) = ''
         , @bLoadDatamart bit = 1;

    SET @CorrectedFileName = @FileName;
    EXEC @i = CountOccurancesOfString @CorrectedFileName, '_';
    IF @i > 1
        BEGIN
            SET @CorrectedFileName = REVERSE (@CorrectedFileName) ;
            SET @i = CHARINDEX ('_', @CorrectedFileName) ;
            SET @CorrectedFileName = STUFF (@CorrectedFileName, @i, 1, '.') ;
            SET @CorrectedFileName = REVERSE (@CorrectedFileName) ;
        END;
    SET @i = CHARINDEX ('.', @CorrectedFileName) ;
    SET @TgtTBL = 'TEMP_' + SUBSTRING (@CorrectedFileName, 1, @i - 1) ;
    SET @i = CHARINDEX ('.', @CorrectedFileName) ;
    IF @i > 0
        BEGIN
            SET @TgtTBL = 'TEMP_' + SUBSTRING (@CorrectedFileName, 1, @i - 1) ;
        END;
    SET @TgtTBL = REPLACE (@TgtTBL, '.', '') ;
    --***********************************************************************************************************
    EXEC @i = dma_LoadFtpData @DBNAME, @Schema, @FtpDir, @FileName, @TgtTBL, @TruncateTempTable, @PreviewOnly;
    --***********************************************************************************************************
   
    --*************************************************************************
    -- LOAD THE DATA MART
    --*************************************************************************
    IF @bLoadDatamart = 1
        BEGIN
            IF CHARINDEX ('RDW_CLINICALINDICATORS', @FileName) > 0
                BEGIN
                    SET @msg = 'START Executing proc_view_RDW_ClinicalIndicators: ' + CAST (GETDATE () AS varchar (50)) ;
				exec printImmediate @msg ;
                    EXEC ADD_ClinicalIndicators_LOG @msg;
                    
				EXEC dbo.proc_view_RDW_ClinicalIndicators;
                    
				SET @msg = 'END Executing proc_view_RDW_ClinicalIndicators: ' + CAST (GETDATE () AS varchar (50)) ;
                    EXEC ADD_ClinicalIndicators_LOG @msg;
				exec printImmediate @msg ;
                END;
            IF CHARINDEX ('siebel_clinicalindicators', @FileName) > 0
                BEGIN
                    SET @msg = 'START Executing proc_view_SIEBEL_ClinicalIndicators: ' + CAST (GETDATE () AS varchar (50)) ;
                    EXEC ADD_ClinicalIndicators_LOG @msg;
				exec printImmediate @msg ;

                    EXEC dbo.proc_view_SIEBEL_ClinicalIndicators;
                    
				SET @msg = 'END Executing proc_view_SIEBEL_ClinicalIndicators: ' + CAST (GETDATE () AS varchar (50)) ;
                    EXEC ADD_ClinicalIndicators_LOG @msg;
				exec printImmediate @msg ;
                END;
        END;

    SET @iCnt = (SELECT COUNT (*)
                   FROM DataMartPlatform.dbo.FTP_ProcessStatus
                   WHERE RunID = @RunID) ;
    IF @iCnt = 0
        BEGIN
            INSERT INTO DataMartPlatform.dbo.FTP_ProcessStatus (RunID
                                                              , ProcessCode
                                                              , Fname
                                                              , Dir
                                                              , CreateDate
                                                              , LastModifiedDate
                                                              , FileSize) 
            VALUES
                   (@RunID, 1, @fname, @dir, @LastModDate, @LastModDate, @FileSize) ;
        END;

    RETURN 1;
END;

GO
PRINT 'executed dma_LoadTextFileIntoTempTable.sql';
GO


