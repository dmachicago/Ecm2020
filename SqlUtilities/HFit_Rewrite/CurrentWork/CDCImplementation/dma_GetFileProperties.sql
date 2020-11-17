


GO 
PRINT 'executing dma_GetFileProperties.sql';
GO

DECLARE
      @FQN nvarchar (2000) = 'X:\ViperTest\TEST_FIS_eligibility_hfc_06132016.txt';
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

GO

/*
declare @LastModDate datetime ;
declare @FileSize int = 0 ;
exec dma_GetFileProperties 'X:\ViperTest\TEST_FIS_eligibility_hfc_06132016.txt' ,@LastModDate, @FileSize ;

select @FileSize, @LastModDate ;

 */

CREATE PROCEDURE dma_GetFileProperties (@FQN nvarchar (2000) , 
                                        @LastModDate datetime OUTPUT , 
                                        @FileSize int OUTPUT) 
AS
BEGIN
    DECLARE
          @TEMP_FILE_INFO TABLE (mdate varchar (8000)) ;
    DECLARE
          @txt nvarchar (1000) = '' , 
          @i int = 0;

EXEC xp_dirtree 'dir ' + @FQN, 10, 1

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
PRINT 'executed dma_GetFileProperties.sql';
GO
