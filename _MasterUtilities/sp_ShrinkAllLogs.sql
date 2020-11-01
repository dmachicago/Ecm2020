use [ECM.Library.FS]
go


create procedure sp_ShrinkAllLogs
as
DECLARE @Name NVARCHAR(50)
DECLARE cur CURSOR FOR

SELECT [name]
FROM [sys].[database_files] 
where [type] = 1

OPEN cur
FETCH NEXT FROM cur INTO @Name
WHILE @@FETCH_STATUS = 0
BEGIN
	print @name
    DBCC SHRINKFILE(@Name, 1)
    FETCH NEXT FROM cur INTO @Name
END
CLOSE cur
DEALLOCATE cur