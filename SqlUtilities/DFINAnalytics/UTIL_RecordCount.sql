

--* USEDFINAnalytics;
GO

IF NOT EXISTS
(
	SELECT 1
	FROM SYS.tables
	WHERE name = 'DFS_RecordCount'
)
-- drop TABLE DFS_RecordCount
-- select * from dbo.DFS_RecordCount
BEGIN
	CREATE TABLE DFS_RecordCount
	( 
				 ProcName nvarchar(150) NOT NULL, 
				 HitCount int NULL DEFAULT 0,
				 SvrName  nvarchar(150) NOT NULL, 
				 DBName  nvarchar(150) NOT NULL, 
				 LastUpdate datetime null,
				 [UID] uniqueidentifier default newid()
	);
END;
GO

IF EXISTS
(
	SELECT 1
	FROM SYS.procedures
	WHERE name = 'UTIL_RecordCount'
)
BEGIN
	DROP PROCEDURE UTIL_RecordCount;
END;
GO

-- truncate table DFS_RecordCount;
-- EXEC UTIL_RecordCount 'xx1';
-- SELECT * FROM DFS_RecordCount;
CREATE PROCEDURE UTIL_RecordCount
( 
				 @procname nvarchar(100)
)
AS
BEGIN
	DECLARE @cnt AS int= 0;
	DECLARE @SvrName nvarchar(150) = @@servername;
	DECLARE @DBName nvarchar(150) = db_name();
	SET @cnt =
	(
		SELECT COUNT(*)
		FROM DFS_RecordCount
		WHERE ProcName = @procname
		and SvrName = @SvrName
		and DBName  =@DBName
	);
	IF @cnt = 0
	BEGIN
		INSERT INTO DFS_RecordCount( ProcName , HitCount, SvrName , DBName, LastUpdate)
		VALUES( @procname, 1, @SvrName, @DBName, getdate() );
	END;
	IF @cnt > 0
	BEGIN
		UPDATE DFS_RecordCount
		  SET HitCount = HitCount + 1, LastUpdate = getdate()
		WHERE ProcName = @procname
		and SvrName = @SvrName
		and DBName  =@DBName;
	END;
END;