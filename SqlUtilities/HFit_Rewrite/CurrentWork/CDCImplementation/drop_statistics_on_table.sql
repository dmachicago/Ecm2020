
DECLARE @db_Table VARCHAR(200)
SET @db_Table =  'BASE_hfit_PPTEligibility'

DECLARE TableStats CURSOR FOR

SELECT Name FROM sys.stats
WHERE object_id = object_id(@db_Table) AND auto_created <> 0

DECLARE @StatName NVARCHAR(512)

OPEN TableStats
FETCH next FROM TableStats INTO @StatName

WHILE @@FETCH_STATUS = 0
BEGIN

EXEC ('drop statistics '+@db_table+'.' + @StatName)
FETCH NEXT FROM TableStats INTO @StatName
END

CLOSE TableStats
DEALLOCATE TableStats
GO