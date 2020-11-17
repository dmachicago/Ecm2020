----* USEMASTER
--* USEDFINAnalytics;
GO

IF OBJECT_ID('tempdb..##usp_myTempWorker') IS NOT NULL
BEGIN
    DROP PROC ##usp_myTempWorker
END
go
CREATE PROC ##usp_myTempWorker AS
	declare @cnt as int = 0 ;
  set @cnt = (SELECT count(*) FROM sys.databases);
  print '@cnt: ' + cast(@cnt as nvarchar(10));
  print 'DB: ' + db_name();
go

/*
declare @stmt nvarchar(1000);
set @stmt = '--* USE?; exec ##usp_myTempWorker';
exec [DFINAnalytics].dbo.sp_foreachdb_TempDB @stmt;
*/
go
if exists (select 1 from sys.procedures where name = 'CREATE PROCEDURE dbo.sp_foreachdb_TempDB')
	drop PROCEDURE dbo.sp_foreachdb_TempDB;
go

/*	Author: W. Dale Miller
	Date:   2018/07/26

	declare @stmt nvarchar(1000) ;
	set @stmt = '--* USE? ; 
 */
CREATE PROCEDURE dbo.sp_foreachdb_TempDB
    @command NVARCHAR(MAX),
    @replace_character NCHAR(1) = N'?',
    @print_dbname BIT = 0,
    @print_command_only BIT = 0,
    @suppress_quotename BIT = 0,
    @system_only BIT = NULL,
    @user_only BIT = NULL,
    @name_pattern NVARCHAR(300) = N'%', 
    @database_list NVARCHAR(MAX) = NULL,
    @recovery_model_desc NVARCHAR(120) = NULL,
    @compatibility_level TINYINT = NULL,
    @state_desc NVARCHAR(120) = N'ONLINE',
    @is_read_only BIT = 0,
    @is_auto_close_on BIT = NULL,
    @is_auto_shrink_on BIT = NULL,
    @is_broker_enabled BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
 @sql NVARCHAR(MAX),
 @dblist NVARCHAR(MAX),
 @db NVARCHAR(300),
 @i INT;

    IF @database_list > N''
    BEGIN
 ;WITH n(n) AS 
 (
     SELECT ROW_NUMBER() OVER (ORDER BY s1.name) - 1
     FROM sys.objects AS s1 
     CROSS JOIN sys.objects AS s2
 )
 SELECT @dblist = REPLACE(REPLACE(REPLACE(x,'</x><x>',','),
 '</x>',''),'<x>','')
 FROM 
 (
     SELECT DISTINCT x = 'N''' + LTRIM(RTRIM(SUBSTRING(
     @database_list, n,
     CHARINDEX(',', @database_list + ',', n) - n))) + ''''
     FROM n WHERE n <= LEN(@database_list)
     AND SUBSTRING(',' + @database_list, n, 1) = ','
     FOR XML PATH('')
 ) AS y(x);
    END

    CREATE TABLE #x(db NVARCHAR(300));

    SET @sql = N'SELECT name FROM sys.databases WHERE 1=1'
 + CASE WHEN @system_only = 1 THEN 
     ' AND database_id IN (1,2,3,4)' 
     ELSE '' END
 + CASE WHEN @user_only = 1 THEN 
     ' AND database_id NOT IN (1,2,3,4)' 
     ELSE '' END
 + CASE WHEN @name_pattern <> N'%' THEN 
     ' AND name LIKE N''%' + REPLACE(@name_pattern, '''', '''''') + '%''' 
     ELSE '' END
 + CASE WHEN @dblist IS NOT NULL THEN 
     ' AND name IN (' + @dblist + ')' 
     ELSE '' END
 + CASE WHEN @recovery_model_desc IS NOT NULL THEN
     ' AND recovery_model_desc = N''' + @recovery_model_desc + ''''
     ELSE '' END
 + CASE WHEN @compatibility_level IS NOT NULL THEN
     ' AND compatibility_level = ' + RTRIM(@compatibility_level)
     ELSE '' END
 + CASE WHEN @state_desc IS NOT NULL THEN
     ' AND state_desc = N''' + @state_desc + ''''
     ELSE '' END
 + CASE WHEN @is_read_only IS NOT NULL THEN
     ' AND is_read_only = ' + RTRIM(@is_read_only)
     ELSE '' END
 + CASE WHEN @is_auto_close_on IS NOT NULL THEN
     ' AND is_auto_close_on = ' + RTRIM(@is_auto_close_on)
     ELSE '' END
 + CASE WHEN @is_auto_shrink_on IS NOT NULL THEN
     ' AND is_auto_shrink_on = ' + RTRIM(@is_auto_shrink_on)
     ELSE '' END
 + CASE WHEN @is_broker_enabled IS NOT NULL THEN
     ' AND is_broker_enabled = ' + RTRIM(@is_broker_enabled)
 ELSE '' END;

 INSERT #x EXEC sp_executesql @sql;

 DECLARE c CURSOR 
     LOCAL FORWARD_ONLY STATIC READ_ONLY
     FOR SELECT CASE WHEN @suppress_quotename = 1 THEN 
 db
  ELSE
 QUOTENAME(db)
  END 
     FROM #x ORDER BY db;

 OPEN c;

 FETCH NEXT FROM c INTO @db;

 WHILE @@FETCH_STATUS = 0
 BEGIN
     SET @sql = REPLACE(@command, @replace_character, @db);

     IF @print_command_only = 1
     BEGIN
  PRINT '/* For ' + @db + ': */'
  + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
  + @sql 
  + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10);
     END
     ELSE
     BEGIN
  IF @print_dbname = 1
  BEGIN
 PRINT '/* ' + @db + ' */';
  END

  EXEC sp_executesql @sql;
     END

     FETCH NEXT FROM c INTO @db;
    END

    CLOSE c;
    DEALLOCATE c;
END
GO