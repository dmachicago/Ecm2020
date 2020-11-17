


CREATE TABLE #TEMP_DOCS (textfile nvarchar (max)) ;

DECLARE
      @bulk_cmd varchar (4000) ;

SET @bulk_cmd = 'BULK INSERT #TEMP_DOCS
FROM ''C:\TEMP\TestDocument.txt'' 
WITH (ROWTERMINATOR = ''' + CHAR (10) + ''')';
EXEC (@bulk_cmd) ;

SELECT * FROM #TEMP_DOCS;