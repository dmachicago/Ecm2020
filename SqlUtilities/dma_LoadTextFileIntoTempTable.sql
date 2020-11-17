


GO 
PRINT 'executing dma_LoadTextFileIntoTempTable.sql';
GO

-- exec dma_LoadTextFileIntoTempTable 'X:\ViperTest\TEST_FIS_eligibility_hfc_06132016.txt';
CREATE PROCEDURE dma_LoadTextFileIntoTempTable (@FQN nvarchar (2000)) 
AS
BEGIN

    DECLARE
          @MySql nvarchar (max) = '';

    BEGIN TRY
        DROP TABLE #TEMP_LINE;
    END TRY
    BEGIN CATCH
        PRINT 'Creating #TEMP_LINE';
    END CATCH;

    CREATE TABLE #TEMP_LINE (line varchar (max) NULL) ;

    SET @MySql = 'BULK INSERT #TEMP_LINE FROM ''' + @FQN + ''' WITH ( ROWTERMINATOR  =''\n'' ) ';
    EXEC (@MySql) ;
END;

GO

ALTER PROCEDURE dma_GetFileProperties (@FQN nvarchar (2000) , 
                                       @LastModDate datetime OUTPUT , 
                                       @FileSize int OUTPUT) 
AS
BEGIN
    DECLARE
          @TEMP_FILE_INFO TABLE (mdate varchar (8000)) ;
    DECLARE
          @txt nvarchar (1000) = '' , 
          @i int = 0;

    SET @txt = 'dir ' + @FQN;
    EXEC xp_dirtree @txt , 10 , 1;

    INSERT INTO @TEMP_FILE_INFO
    EXEC sys.xp_cmdshell @FQN;

    SET @LastModDate = CAST ((SELECT TOP (1) SUBSTRING (mdate , 1 , 20) AS 'LastModifiedDate'
                                FROM @TEMP_FILE_INFO
                                WHERE mdate LIKE '%TEST_FIS_eligibility_hfc_06132016.txt%') AS datetime) ;
    PRINT @LastModDate;

    SET @txt = (SELECT TOP (1) SUBSTRING (mdate , 22 , 9999)
                  FROM @TEMP_FILE_INFO
                  WHERE mdate LIKE '%' + @FQN + '%') ;
    SET @txt = LTRIM (@txt) ;
    PRINT '@txt = ''' + @txt + '''';
    SET @i = CHARINDEX (' ' , @txt) ;
    SET @txt = SUBSTRING (@txt , 1 , @i - 1) ;
    PRINT '@txt = ''' + @txt + '''';
    SET @txt = REPLACE (@txt , ',' , '') ;
    PRINT '@txt = ''' + @txt + '''';
    SET @FileSize = CAST (@txt AS int) ;
    PRINT '@FileSize = ''' + CAST (@FileSize AS nvarchar (50)) + '''';
END;






GO 
PRINT 'executed dma_LoadTextFileIntoTempTable.sql';
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
