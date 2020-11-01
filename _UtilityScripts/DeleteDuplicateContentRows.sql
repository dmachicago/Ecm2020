ALTER DATABASE [ECM.Library.FS] SET RECOVERY SIMPLE
go
--**************************************************************
-- Looping Delete if Needed
-- Find XXX and change it as needed for the FQN delete 
set nocount off
DECLARE @i AS INTEGER= 0;
DECLARE @RowsRemaining AS INTEGER= 0;
DECLARE @Rows AS INTEGER= 0;
DECLARE @msg NVARCHAR(500)= '';
DECLARE @filter NVARCHAR(500)= 'c:\temp\%';
SET @RowsRemaining =
(
    SELECT COUNT(*)
    FROM DataSource
    WHERE FQN LIKE @filter
);
set @msg = 'Total Rows to delete: ' + convert(nvarchar(20), @RowsRemaining);
exec sp_PrintImmediate @msg;
SET @Rows = @RowsRemaining;
WHILE @RowsRemaining > 0
    BEGIN
        SET @i = @i + 1;
        IF(@i % 2 = 0)
            BEGIN
                SET @msg = 'Deleted : ' + CAST((@Rows - @i) AS VARCHAR(20)) + ' :  Remaining : ' + CAST(@RowsRemaining AS VARCHAR(20));
                EXEC sp_PrintImmediate @msg;
        END;
        BEGIN TRANSACTION;
			DELETE FROM DataSource
			WHERE SourceGuid IN
			(
				SELECT TOP 10 SourceGuid
				FROM DataSource
				WHERE FQN LIKE @filter
			);
        COMMIT TRANSACTION;
		CHECKPOINT;
		EXEC sp_filestream_force_garbage_collection @dbname = N'ECM.Library.FS';  
		--DBCC SHRINKFILE (N'ECM.Library.FS_log');
		--DBCC SQLPERF(LogSpace)
		--DBCC SHRINKFILE (N'ECM.Library.FS_log', TRUNCATEONLY)
		--exec sp_ShrinkAllLogs ;
		--DBCC LOGINFO
        SET @RowsRemaining = @RowsRemaining - 10;
    END;
PRINT 'Completed Total Deletions: ' + CAST(@i AS NVARCHAR(20));
--**************************************************************
--**************************************************************

EXEC sp_PrintImmediate 'Removing remaining duplicates';
set nocount on
WITH cte
     AS (SELECT ImageHash, ROW_NUMBER() OVER(PARTITION BY ImageHash
         ORDER BY ImageHash) AS row_num
         FROM dbo.DataSource)
     DELETE FROM cte
     WHERE row_num > 1;


EXEC sp_PrintImmediate '************   COMPLETE   ************';

go
ALTER DATABASE [ECM.Library.FS] SET RECOVERY FULL
go
