


GO 
PRINT 'executing dma_GetFileProperties.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'dma_GetFileProperties') 
    BEGIN
        DROP PROCEDURE dma_GetFileProperties
    END;
GO


/*
declare @LastModDate datetime ;
declare @FileSize int = 0, @fname nvarchar (1000) , @dir nvarchar (1000) ;
exec dma_GetFileProperties 'X:\ViperTest\TEST_FIS_eligibility_hfc_06132016.txt', @LastModDate output, @FileSize output, @fname output, @dir output;
select @LastModDate, @FileSize, @fname , @dir  ;
*/

CREATE PROCEDURE dma_GetFileProperties (@FQN nvarchar (2000) 
                                      , @LastModDate datetime OUTPUT
                                      , @FileSize int OUTPUT
                                      , @fname nvarchar (1000) OUTPUT
                                      , @dir nvarchar (1000) OUTPUT) 
AS
BEGIN

    --declare @FQN nvarchar (2000) = 'X:\ViperTest\TEST_FIS_eligibility_hfc_06132016.txt' ;
    --declare @LastModDate datetime ;
    --declare @FileSize int = 0 ;

    DECLARE
           @MySql nvarchar (max) = ''
         , @txt nvarchar (1000) = ''
         , @i int = 0;

    SET @dir = REVERSE (@FQN) ;
    SET @i = CHARINDEX ('\', @dir) ;
    SET @dir = SUBSTRING (@dir, @i + 1, 9999) ;
    SET @dir = REVERSE (@dir) ;

    SET @fname = REVERSE (@FQN) ;
    SET @i = CHARINDEX ('\', @fname) ;
    SET @fname = SUBSTRING (@fname, 1, @i - 1) ;
    SET @fname = REVERSE (@fname) ;

    BEGIN TRY
        CREATE TABLE #TEMP_FILE_INFO (mdate varchar (8000)) ;
    END TRY
    BEGIN CATCH 
    --print 'using #TEMP_FILE_INFO ' ; 
    END CATCH;

    SET @MySql = 'INSERT INTO #TEMP_FILE_INFO EXEC sys.xp_cmdshell ''DIR ' + @FQN + '''';
    --print @MySql ;
    EXEC (@MySql) ;

    DECLARE
           @WildCard nvarchar (500) = '%' + @fname + '%';
    --print '@WildCard: ' + @WildCard ;

    SET @LastModDate = CAST ((SELECT TOP (1) SUBSTRING (mdate, 1, 20) AS 'LastModifiedDate'
                                FROM #TEMP_FILE_INFO
                                WHERE mdate LIKE @WildCard) AS datetime) ;
    --print @LastModDate;

    SET @txt = (SELECT TOP (1) SUBSTRING (mdate, 22, 9999)
                  FROM #TEMP_FILE_INFO
                  WHERE mdate LIKE @WildCard) ;

    SET @txt = LTRIM (@txt) ;
    --print '@txt = ''' + @txt + '''';
    SET @i = CHARINDEX (' ', @txt) ;
    SET @txt = SUBSTRING (@txt, 1, @i - 1) ;
    --print '@txt = ''' + @txt + '''';
    SET @txt = REPLACE (@txt, ',', '') ;
    --print '@txt = ''' + @txt + '''';
    SET @FileSize = CAST (@txt AS int) ;
--print '@FileSize = ''' + CAST (@FileSize AS nvarchar (50)) + '''';
END;

GO 
PRINT 'executed dma_GetFileProperties.sql';
GO
