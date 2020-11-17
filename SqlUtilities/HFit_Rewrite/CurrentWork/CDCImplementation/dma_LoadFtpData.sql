USE [DataMartPlatform];
GO

/****** Object:  StoredProcedure [dbo].[dma_LoadFtpData]    Script Date: 11/25/2016 1:08:17 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
ALTER PROCEDURE dbo.dma_LoadFtpData (@DBNAME nvarchar (100) = 'DataMartPlatform'
                                   , @Schema nvarchar (100) = 'dbo'
                                   , @FtpDir nvarchar (500) = 'Z:\ImportFiles\ClinicalIndicators_Import'
                                   , @FileName nvarchar (500) 
                                   , @TgtTBL nvarchar (500) 
                                   , @TruncateTempTable int = 0
                                   , @PreviewOnly int = 0) 
AS
BEGIN
    DECLARE
           @FQN nvarchar (2000) = ''
         , @ErrFile nvarchar (2000) = ''
         , @msg nvarchar (2000) = ''
         , @MySql nvarchar (max) = ''
         , @RC int = 0
         , @iCnt int = 0;

    SET @ErrFile = @FtpDir + '\ERROR\' + @FileName + '.ERR';
    SET @FQN = @FtpDir + '\' + @FileName;
    SET @FQN = REPLACE (@FQN, '\\', '\') ;
    PRINT ' ';

    SET @msg = 'PROCESSING: ' + @FQN;
    EXEC printImmediate @msg;
    EXEC ADD_ClinicalIndicators_LOG @msg;

    SET @msg = 'STARTED dma_LoadFtpData: ' + CAST (GETDATE () AS nvarchar (50)) ;
    EXEC printImmediate @msg;
    EXEC ADD_ClinicalIndicators_LOG @msg;

    IF @TruncateTempTable = 1
   AND @PreviewOnly = 0
        BEGIN
            SET @MySql = 'truncate table ' + @DBNAME + '.dbo.' + @TgtTBL + ';';
            EXEC (@MySql) ;
        END;
    IF @TruncateTempTable = 1
   AND @PreviewOnly = 1
        BEGIN
            SET @MySql = 'truncate table ' + @DBNAME + '.dbo.' + @TgtTBL + ';';
            PRINT @MySql;
        END;

    SET @MySql = '';
    SET @MySql = @MySql + 'BULK INSERT ' + @DBNAME + '.' + @Schema + '.' + @TgtTBL + CHAR (10) ;
    SET @MySql = @MySql + '    FROM ''' + @FQN + '''' + CHAR (10) ;
    SET @MySql = @MySql + '        WITH (FIRSTROW = 2, KEEPNULLS, FIELDTERMINATOR = '','', ROWTERMINATOR = ''0x0a'', ERRORFILE = ''' + @ErrFile + ''' );';
    --SET @MySql = @MySql + '    WITH (FIRSTROW = 2, LASTROW = 50000, KEEPNULLS, FIELDTERMINATOR = '','', ROWTERMINATOR = ''0x0a'', ERRORFILE = ''' + @ErrFile + ''' );';
    
    --EXEC PrintImmediate @MySql;
    EXEC ADD_ClinicalIndicators_LOG @MySql;

    IF @PreviewOnly = 1
        BEGIN
            PRINT @MySql;
        END;
    ELSE
        BEGIN EXEC (@MySql) ;
            SET @iCnt = @@ROWCOUNT;
        END;
    SET @msg = '** END dma_LoadFtpData: ' + CAST (GETDATE () AS nvarchar (50)) + ' / Records Added: ' + CAST (@iCnt AS nvarchar (50)) ;
    EXEC printImmediate @msg;
    EXEC ADD_ClinicalIndicators_LOG @msg;

    SET @RC = 1;
    RETURN @RC;
END; 

