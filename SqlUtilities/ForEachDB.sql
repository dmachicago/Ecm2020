CREATE TABLE ##allTables
(
	DBName sysname NOT NULL,
	TableName sysname NOT NULL
);

DECLARE @SqlTemplate NVARCHAR(MAX) = N'
USE [?];

INSERT	INTO ##allTables(DBName, TableName)
SELECT	''?'' AS DBName, Name AS TableName
FROM	sys.tables;
';

DECLARE @name sysname, @SQL NVARCHAR(MAX);

DECLARE dbcursor CURSOR READ_ONLY FAST_FORWARD FOR
SELECT	name FROM sys.databases
WHERE	state = 0
	AND name NOT IN ('master', 'tempdb', 'model', 'msdb', 'DBA');

OPEN dbcursor;
FETCH NEXT FROM dbcursor INTO @name;

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @SQL = REPLACE(@SqlTemplate, N'?', @name);
	EXEC (@SQL); --could also paramterize and use sp_ExecuteSQL

	FETCH NEXT FROM dbcursor INTO @name;
END;

CLOSE dbcursor;
DEALLOCATE dbcursor;

SELECT	DBName, TableName
FROM	##allTables;

DROP TABLE ##allTables;