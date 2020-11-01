--SELECT TYPE_DESC, NAME, size, max_size, growth, is_percent_growth FROM sys.database_files;

DECLARE @FileName sysname = N'ECM.Library.FS_log';
DECLARE @TargetSize INT = (SELECT 1 + size*8./1024 FROM sys.database_files WHERE name = @FileName);
DECLARE @Factor FLOAT = .999;
DECLARE @I int = 0;

print '@FileName: ' + @FileName;
print '@TargetSize: ' + cast(@TargetSize as nvarchar(20));
print '@Factor: ' + cast(@Factor as nvarchar(20));

WHILE @TargetSize > 0
BEGIN
	Set @I += 1;
    SET @TargetSize *= @Factor;
    DBCC SHRINKFILE(@FileName, @TargetSize);
    DECLARE @msg VARCHAR(200) = CONCAT('Shrink file completed. Target Size: ', 
         @TargetSize, ' MB. Timestamp: ', CURRENT_TIMESTAMP);
    RAISERROR(@msg, 1, 1) WITH NOWAIT;
    WAITFOR DELAY '00:00:01';
	print '@I = '  + cast(@I as nvarchar(20))
END;