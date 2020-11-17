DECLARE @DBName VARCHAR(100) = (SELECT DB_NAME())

DECLARE @FilePath NVARCHAR(500) = 'SELECT @FilePath = REVERSE(SUBSTRING(REVERSE(filename),PATINDEX(''%[\]%'',REVERSE(filename)) ,100)) FROM ' + @DBName + '..sysfiles WHERE FileID = 1',
  @FileName NVARCHAR(500) = (SELECT @DBName + '_ss' + FORMAT(GETDATE(),'yyyyMMdd_HHmm')),
  @DataFile NVARCHAR(100) = 'SELECT @DataFile = name FROM ' + @DBName + '..sysfiles WHERE FileID = 1',
  @SQL VARCHAR(1000)

--Set Parameters
EXEC sp_executesql @FilePath, N'@FilePath NVARCHAR(500) out', @FilePath OUT
EXEC sp_executesql @DataFile, N'@DataFile NVARCHAR(500) out', @DataFile OUT

SET @SQL = 'CREATE DATABASE ' + @FileName + ' ON ( NAME = ' + @DataFile + ', FILENAME = ''' + @FilePath + @FileName + '.ss'' ) AS SNAPSHOT OF ' + @DBName
print @SQL

EXEC(@SQL)

declare @PName as nvarchar(200) = DB_NAME() + '_ss%'
SELECT 
        * 
    FROM 
        sys.databases 
    WHERE 
        name like @PName
    AND source_database_id IS NOT NULL
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
