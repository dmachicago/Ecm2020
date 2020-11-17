
SELECT obj.name, 
       SUM(reserved_page_count) * 8.0 AS "size in KB"
FROM sys.dm_db_partition_stats part, 
     sys.objects obj
WHERE part.object_id = obj.object_id
GROUP BY obj.name;

--******************************************************************************

DECLARE @TableName varchar(255)
 
 DECLARE TableCursor CURSOR FOR
 (
 SELECT '[' + IST.TABLE_SCHEMA + '].[' + IST.TABLE_NAME + ']' AS [TableName]
 FROM INFORMATION_SCHEMA.TABLES IST
 WHERE IST.TABLE_TYPE = 'BASE TABLE'
 )
 
 OPEN TableCursor
 FETCH NEXT FROM TableCursor INTO @TableName
 WHILE @@FETCH_STATUS = 0
 
 BEGIN
 PRINT('Rebuilding Indexes on ' + @TableName)
 Begin Try
 EXEC('ALTER INDEX ALL ON ' + @TableName + ' REBUILD with (ONLINE=ON)')
 End Try
 Begin Catch
 PRINT('Cannot do rebuild with Online=On option, taking table ' + @TableName+' down for douing rebuild')
 EXEC('ALTER INDEX ALL ON ' + @TableName + ' REBUILD')
 End Catch
 FETCH NEXT FROM TableCursor INTO @TableName
 END
 
 CLOSE TableCursor
 DEALLOCATE TableCursor