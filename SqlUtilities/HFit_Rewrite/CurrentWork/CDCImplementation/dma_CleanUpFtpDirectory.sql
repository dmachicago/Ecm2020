USE [DataMartPlatform];
GO

/****** Object:  StoredProcedure [dbo].[dma_CleanUpFtpDirectory]    Script Date: 12/7/2016 1:58:42 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- exec dma_CleanUpFtpDirectory 1
ALTER PROCEDURE dbo.dma_CleanUpFtpDirectory (@PreviewOnly bit = 0) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
           @MySql AS nvarchar (max) = ''
         , @msg varchar (2000) = ''
         , @FName varchar (200) = ''
         , @DaysToKeepFtpFiles int = 7
         , @PickupLocation nvarchar (250) = ''
         , @FileMask nvarchar (250) = ''
         , @CreateDate datetime
         , @FTP_Directory nvarchar (250) = 'Z:\ImportFiles\ClinicalIndicators_Import\Processing\';

    DECLARE
           @T AS TABLE (dir nvarchar (250) 
                      , fname nvarchar (250) 
                      , line nvarchar (max)) ;


    IF NOT EXISTS (SELECT NAME
                     FROM SYS.TABLES
                     WHERE NAME = 'TEMP_DIR_ITEMS') 
        BEGIN
            CREATE TABLE TEMP_DIR_ITEMS (line varchar (8000)) ;
        END;
    IF NOT EXISTS (SELECT NAME
                     FROM SYS.TABLES
                     WHERE NAME = 'FTP_ClinicalIndicators_LOG') 
        BEGIN
            CREATE TABLE FTP_ClinicalIndicators_LOG (logdate datetime DEFAULT GETDATE () 
                                                   , logentry varchar (4000)) ;
        END;

    truncate TABLE TEMP_DIR_ITEMS;

    SET @msg = '** START FTP FILE CLEANUP: ' + CAST (GETDATE () AS nvarchar (50)) + ' / @DaysToKeepFtpFiles = ' + CAST (@DaysToKeepFtpFiles AS nvarchar (20)) ;
    EXEC ADD_ClinicalIndicators_LOG @msg;
    -- select RunID, FName from [dbo].FTP_ProcessStatus where CreateDate > getdate()-7 ;

    DECLARE C CURSOR
        FOR SELECT DISTINCT PickupLocation
              FROM dma_FtpDirectory;
    OPEN C;

    FETCH NEXT FROM C INTO @PickupLocation;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            SET @MySql = 'INSERT INTO TEMP_DIR_ITEMS EXEC sys.xp_cmdshell ''DIR ' + @PickupLocation + '\*.csv /B /OD''';
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
              FROM TEMP_DIR_ITEMS;

            SET @msg = 'PROCESSING FQN: ' + @PickupLocation + ' : ' + @FileMask;
            PRINT @msg;
            EXEC ADD_ClinicalIndicators_LOG @msg;

            FETCH NEXT FROM C INTO @PickupLocation;
        END;

    CLOSE C;
    DEALLOCATE C;

    -- SELECT * FROM @T;

    DECLARE C2 CURSOR
        FOR SELECT P.FName
                 , CreateDate
              FROM dbo.FTP_ProcessStatus P
                   JOIN
                   @T
                   ON line = P.FName
              WHERE CreateDate < GETDATE () - @DaysToKeepFtpFiles;
    OPEN C2;

    FETCH NEXT FROM C2 INTO @FName, @CreateDate;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @PreviewOnly = 1
                BEGIN
                    PRINT 'PreviewOnly - REMOVING FILE: ' + @FName + ' : ' + CAST (@CreateDate AS nvarchar (50)) ;
                END;
            ELSE
                BEGIN
                    SET @msg = '!! REMOVING FILE: ' + @FName + ' : ' + CAST (@CreateDate AS nvarchar (50)) ;
                    EXEC ADD_ClinicalIndicators_LOG @msg;
                    PRINT @msg;

                    SET @MySql = 'EXEC sys.xp_cmdshell ''DEL ' + @FTP_Directory + @FName + '''';
                    PRINT @MySql;
                    BEGIN TRY EXEC (@MySql) ;
                        SET @msg = 'REMOVED FILE: ' + @FName;
                        EXEC ADD_ClinicalIndicators_LOG @msg;
                        PRINT @msg;
                    END TRY
                    BEGIN CATCH
                        SET @msg = 'FATAL ERROR (dma_CleanUpFtpDirectory) : ' + @FName;
                        EXEC ADD_ClinicalIndicators_LOG @msg;
                        PRINT @msg;
                    END CATCH;
                END;
            FETCH NEXT FROM C2 INTO @FName, @CreateDate;
        END;

    CLOSE C2;
    DEALLOCATE C2;

    SET @msg = '** END FTP FILE CLEANUP: ' + CAST (GETDATE () AS nvarchar (50)) ;
    EXEC ADD_ClinicalIndicators_LOG @msg;
    PRINT @msg;
END;

