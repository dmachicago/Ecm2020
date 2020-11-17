USE DataMartPlatform;
GO
DECLARE
       @TestThis int = 0;
IF @TestThis = 1
    BEGIN 
	   EXEC dma_LoadFtpData @DBNAME = 'DataMartPlatform', @Schema = 'dbo', @FtpDir = 'Z:\ImportFiles\ClinicalIndicators_Import', @FileName = 'rdw_clinicalindicators.2016.11.21.18.55.20.csv', @TgtTBL = 'TEMP_RDW_ClinicalIndicators', @TruncateTempTable = 1, @PreviewOnly = 1;
        EXEC dma_LoadFtpData @DBNAME = 'DataMartPlatform', @Schema = 'dbo', @FtpDir = 'Z:\ImportFiles\ClinicalIndicators_Import', @FileName = 'RDW_CLINICALINDICATORS.2016.11.22.17.17.00.csv', @TgtTBL = 'TEMP_RDW_ClinicalIndicators', @TruncateTempTable = 0, @PreviewOnly = 1;
        EXEC dma_LoadFtpData @DBNAME = 'DataMartPlatform', @Schema = 'dbo', @FtpDir = 'Z:\ImportFiles\ClinicalIndicators_Import', @FileName = 'RDW_CLINICALINDICATORS_16.11.23.10.16.06.csv', @TgtTBL = 'TEMP_RDW_ClinicalIndicators', @TruncateTempTable = 0, @PreviewOnly = 1;
        
	   EXEC dma_LoadFtpData @DBNAME = 'DataMartPlatform', @Schema = 'dbo', @FtpDir = 'Z:\ImportFiles\ClinicalIndicators_Import', @FileName = 'siebel_clinicalindicators.2016.11.21.19.51.05.csv', @TgtTBL = 'TEMP_SIEBEL_ClinicalIndicators', @TruncateTempTable = 1, @PreviewOnly = 1;        
	   EXEC dma_LoadFtpData @DBNAME = 'DataMartPlatform', @Schema = 'dbo', @FtpDir = 'Z:\ImportFiles\ClinicalIndicators_Import', @FileName = 'siebel_clinicalindicators.2016.11.22.17.18.18.csv', @TgtTBL = 'TEMP_SIEBEL_ClinicalIndicators', @TruncateTempTable = 0, @PreviewOnly = 1;        
	   EXEC dma_LoadFtpData @DBNAME = 'DataMartPlatform', @Schema = 'dbo', @FtpDir = 'Z:\ImportFiles\ClinicalIndicators_Import', @FileName = 'siebel_clinicalindicators_16.11.23.10.26.41.csv', @TgtTBL = 'TEMP_SIEBEL_ClinicalIndicators', @TruncateTempTable = 0, @PreviewOnly = 1;        
    END;
GO
ALTER PROCEDURE dma_LoadFtpData (@DBNAME nvarchar (100) = 'DataMartPlatform'
                               , @Schema nvarchar (100) = 'dbo'
                               , @FtpDir nvarchar (500) = 'Z:\ImportFiles\ClinicalIndicators_Import'
                               , @FileName nvarchar (500) 
                               , @TgtTBL nvarchar (500) 
                               , @TruncateTempTable int = 0
                               , @PreviewOnly int = 0) 
AS
BEGIN
    DECLARE
           @FQN nvarchar (2000) = '',
		 @ErrFile nvarchar (2000) = '',
		 @msg nvarchar (2000) = '',
           @MySql nvarchar (max) = '';

    set @ErrFile = @FtpDir + '\' + @FileName + '.ERR';
    SET @FQN = @FtpDir + '\' + @FileName;
    SET @FQN = REPLACE (@FQN, '\\', '\') ;
    print ' ' ;
    set @msg =  'PROCESSING: ' + @FQN ; 
    exec printImmediate @msg ;
    set @msg =  'STARTED: ' + cast(getdate() as nvarchar(50)) ;
    exec printImmediate @msg ;
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
    --set @MySql = @MySql + 'WITH (FORMATFILE = ''' + @FtpDir + '\' + @TgtTBL + '.Fmt'');'  ;
    SET @MySql = @MySql + '        WITH (FIRSTROW = 2, 
	   KEEPNULLS, FIELDTERMINATOR = '','', 
	   ROWTERMINATOR = ''0x0a'', 
	   ERRORFILE = ''' + @ErrFile + ''' );';

    IF @PreviewOnly = 1
        BEGIN
            PRINT @MySql;
        END
    ELSE
        BEGIN EXEC (@MySql) ;
        END;
    set @msg =  'ENDED: ' + cast(getdate() as nvarchar(50)) ;
    exec printImmediate @msg ;
    exec printImmediate @msg ;
END; 

GO 

/*

bcp DataMartPlatform.dbo.Employees format nul -c -t, -r \r\n -f Z:\ImportFiles\ClinicalIndicators_Import\TEMP_SIEBEL_ClinicalIndicators.fmt -S localhost\SqlSrv2014 -T

--delete any existing table rows before importing the data file.
truncate table DataMartPlatform.dbo.TEMP_SIEBEL_ClinicalIndicators;
select count(*) from DataMartPlatform.dbo.TEMP_SIEBEL_ClinicalIndicators;

BULK INSERT DataMartPlatform.dbo.TEMP_SIEBEL_ClinicalIndicators
   FROM 'Z:\ImportFiles\ClinicalIndicators_Import\SIEBEL_CLINICALINDICATORS.2016.11.21.19.51.05.csv'    
   WITH (FIRSTROW = 2, KEEPNULLS, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a' );

BULK INSERT DataMartPlatform.dbo.TEMP_SIEBEL_ClinicalIndicators
   FROM 'Z:\ImportFiles\ClinicalIndicators_Import\SIEBEL_CLINICALINDICATORS.2016.11.21.19.51.05.csv' 
   WITH (FIRSTROW = 2, KEEPNULLS, FORMATFILE = 'Z:\ImportFiles\ClinicalIndicators_Import\STAGING_view_SIEBEL_ClinicalIndicators.Fmt');
GO
SELECT * FROM STAGING_view_SIEBEL_ClinicalIndicators;
GO

-- alter table [dbo].[TEMP_SIEBEL_ClinicalIndicators] alter column [WEIGHT] decimal (5,2) null

USE DataMartPlatform;
GO
--delete any existing table rows before importing the data file.
truncate table DataMartPlatform.dbo.STAGING_view_RDW_ClinicalIndicators;
DELETE DataMartPlatform.dbo.TEMP_RDW_ClinicalIndicators ;
GO
BULK INSERT DataMartPlatform.dbo.STAGING_view_RDW_ClinicalIndicators
   FROM 'Z:\ImportFiles\ClinicalIndicators_Import\RDW_CLINICALINDICATORS.2016.11.21.18.55.20.csv' 
   WITH (FIRSTROW = 2, FORMATFILE = 'Z:\ImportFiles\ClinicalIndicators_Import\STAGING_view_RDW_ClinicalIndicators.Fmt');

--the below seems to work best.
BULK INSERT DataMartPlatform.dbo.TEMP_RDW_ClinicalIndicators
   FROM 'Z:\ImportFiles\ClinicalIndicators_Import\RDW_CLINICALINDICATORS.2016.11.21.18.55.20.csv' 
   WITH (FIRSTROW = 2, KEEPNULLS, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a' );

GO
SELECT * FROM STAGING_view_SIEBEL_ClinicalIndicators;
GO
*/