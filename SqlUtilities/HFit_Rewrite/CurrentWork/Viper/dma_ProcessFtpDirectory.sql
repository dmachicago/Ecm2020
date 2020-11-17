
-- select * from dma_FtpDirectory
-- select * from TEMP_DIR_FILES
/*
truncate table [dbo].[BASE_view_RDW_ClinicalIndicators]
truncate table [dbo].[BASE_view_RDW_ClinicalIndicators_DEL]
truncate table [dbo].[BASE_view_SIEBEL_ClinicalIndicators]
truncate table [dbo].[BASE_view_SIEBEL_ClinicalIndicators_DEL]
truncate table [dbo].[STAGING_view_RDW_ClinicalIndicators]
truncate table [dbo].[STAGING_view_SIEBEL_ClinicalIndicators]
truncate table [dbo].[TEMP_RDW_ClinicalIndicators]
truncate table [dbo].[TEMP_SIEBEL_ClinicalIndicators]
truncate table [dbo].FTP_ProcessStatus
truncate table FTP_ClinicalIndicators_LOG
*/
GO
PRINT 'executing dma_ProcessFtpDirectory.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'dma_ProcessFtpDirectory') 
    BEGIN
        DROP PROCEDURE dma_ProcessFtpDirectory;
    END;
GO
-- exec dma_ProcessFtpDirectory 0
CREATE PROCEDURE dma_ProcessFtpDirectory (@PreviewOnly bit = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
           @MySql AS nvarchar (max) = ''
         , @cols AS nvarchar (max) = ''
         , @CMD AS nvarchar (250) = ''
         , @PickupLocation nvarchar (250) = ''
         , @FileMask nvarchar (250) = ''
	    , @msg varchar(2000) = '' ;

    DECLARE
           @FileMasks AS TABLE (MaskName nvarchar (100)) ;

    DECLARE
           @T AS TABLE (dir nvarchar (250) 
                      , fname nvarchar (250) 
                      , line nvarchar (max)) ;

    set @msg = '** START FTP FILE PROCESSING: ' + CAST (getdate() AS nvarchar (50)) ;
    EXEC ADD_ClinicalIndicators_LOG @msg;

    INSERT INTO @FileMasks
    SELECT DISTINCT FileMask
      FROM dma_FtpDirectory;

    IF NOT EXISTS (SELECT NAME
                     FROM SYS.TABLES
                     WHERE NAME = 'TEMP_DIR_FILES') 
        BEGIN
            CREATE TABLE TEMP_DIR_FILES (line varchar (8000)) ;
        END;
	   IF NOT EXISTS (SELECT NAME
                     FROM SYS.TABLES
                     WHERE NAME = 'FTP_ClinicalIndicators_LOG') 
        BEGIN
            CREATE TABLE FTP_ClinicalIndicators_LOG (logdate datetime default getdate(), logentry varchar (4000)) ;
        END;
    truncate TABLE TEMP_DIR_FILES;

    DECLARE C CURSOR
        FOR SELECT DISTINCT PickupLocation
                          , FileMask
              FROM dma_FtpDirectory;
    OPEN C;

    FETCH NEXT FROM C INTO @PickupLocation, @FileMask;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @PreviewOnly = 1
                BEGIN
                    PRINT 'PROCESSING DIR: ' + @PickupLocation;				
                END;
            SET @MySql = 'INSERT INTO TEMP_DIR_FILES EXEC sys.xp_cmdshell ''DIR ' + @PickupLocation + '\*.csv /B /OD''';
            IF @PreviewOnly = 1
                BEGIN
                    PRINT @MySql;
                END;
            BEGIN TRY
                EXEC (@MySql) ;
            END TRY
            BEGIN CATCH
                PRINT 'ERROR PROCESSING: ' + @PickupLocation;
            END CATCH;

            INSERT INTO @T (dir
                          , fname
                          , line) 
            SELECT @PickupLocation
                 , @FileMask
                 , line
              FROM TEMP_DIR_FILES;
		    
             set @msg = 'PROCESS FQN: ' + @PickupLocation + ' : ' + @FileMask;
		   EXEC ADD_ClinicalIndicators_LOG @msg;

            FETCH NEXT FROM C INTO @PickupLocation, @FileMask;
        END;

    CLOSE C;
    DEALLOCATE C;

    --select distinct line from TEMP_DIR_FILES order by line
    --select * from @T

    DECLARE
           @FQN nvarchar (1000) = ''
         , @dir nvarchar (1000) = ''
         , @fname nvarchar (1000) = ''
         , @line nvarchar (max) = ''
         , @iCnt int = 0;

    DECLARE C2 CURSOR
        FOR SELECT DISTINCT dir
                          , fname
                          , line
              FROM @T AS T
                   JOIN
                   @FileMasks AS F
                   ON T.line LIKE '%' + F.MaskName + '%'
              WHERE line IS NOT NULL
                AND line NOT LIKE '%The system cannot find the file specified%'
			 order by line;

    OPEN C2;
    DECLARE
           @ProcessedFiles TABLE (fqn nvarchar (500)) ;
    FETCH NEXT FROM C2 INTO @dir, @fname, @line;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            SET @FQN = @dir + '\' + @Line;
            SET @iCnt = (SELECT COUNT (*)
                           FROM FTP_ProcessStatus
                           WHERE fname = @Line
                             AND ProcessCode = 1) ;
            IF @iCnt > 0
                BEGIN
                    SET @msg = 'NOTICE: File ' + @Line + ', appears to have already been processed, SKIPPING.';				
				EXEC ADD_ClinicalIndicators_LOG @msg;
				print @msg ;
                END;
            IF @PreviewOnly = 0
           AND @iCnt = 0
                BEGIN
                    SET @msg = 'LOADING @line: ' + @FQN;
                    EXEC printImmediate @msg;
				exec ADD_ClinicalIndicators_LOG @msg ;
                    DECLARE
                           @rc int = 0
                         , @RunID nvarchar (80) = '';
                    --***************************************************************
				set @msg = 'BEGIN dma_LoadTextFileIntoTempTable: @' + @Line + ' : ' + CAST (getdate() AS nvarchar (50)) ;
				EXEC ADD_ClinicalIndicators_LOG @msg;
                    EXEC dma_LoadTextFileIntoTempTable @dir, @Line, @RunID OUTPUT;
				set @msg = 'END dma_LoadTextFileIntoTempTable: @' + @Line + ' : ' + CAST (getdate() AS nvarchar (50)) ;
				EXEC ADD_ClinicalIndicators_LOG @msg;
                    --***************************************************************
                    PRINT '@RunID: ' + CAST (@RunID AS nvarchar (75)) ;
                END;
            
            FETCH NEXT FROM C2 INTO @dir, @fname, @line;
        END;
    CLOSE C2;
    DEALLOCATE C2;
    SET NOCOUNT OFF;
    set @msg = '** END FTP FILE PROCESSING: ' + CAST (getdate() AS nvarchar (50)) ;
    EXEC ADD_ClinicalIndicators_LOG @msg;
    exec dma_CleanUpFtpDirectory ;
END;

GO
PRINT 'executed dma_ProcessFtpDirectory.sql';
GO